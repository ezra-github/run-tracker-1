import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:run_keeper/components/app_custom_card.dart';
import 'package:run_keeper/components/app_custom_dialog.dart';
import 'package:run_keeper/constants/constants.dart';
import 'package:run_keeper/constants/text_formatter.dart';
import 'package:run_keeper/model/run_data.dart';
import 'package:run_keeper/pages/home/home_controller.dart';
import 'package:run_keeper/pages/login/login_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({ Key key }) : super(key: key);

  final HomeController homCon = Get.put(HomeController());
  final LoginController logCon = Get.put(LoginController());

  final customDialog = CustomDialog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.colorPrimary,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: Row(
          children: [
            Image.asset(
              "assets/app_icon.png",
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                CustomText.title,
                style: CustomTextStyle.header(textcolor: CustomTheme.colorWhite),
              ),
            ),
            Expanded(child: Container()),
            IconButton(
              icon: Icon(Icons.power_settings_new), onPressed: ()=> logCon.signOutUser()
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: Text(
                "Hello Anon,",
                style: CustomTextStyle.header(textcolor: CustomTheme.colorPrimary),
              ),
            ),

            Container(
              child: Obx(() {
                switch (homCon.isFetching.value) {
                  case true:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    
                    break;
                  
                  case false:
                    return homCon.runDataList.value.length > 0 ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: homCon.runDataList.value.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, i){
                        RunDataModel runDataModel = RunDataModel(homCon.runDataList.value[i].id, homCon.runDataList.value[i].updateRunData());
                        return CustomCard(
                          month: TextFormatter.getMonth(runDataModel.dateCreated),
                          date: TextFormatter.getDate(runDataModel.dateCreated),
                          title: runDataModel.title,
                          distance: runDataModel.distance,
                          start: TextFormatter.getStartDate(runDataModel.startDate),
                          end: TextFormatter.getEndDate(runDataModel.endDate),
                          onTapEdit: (){
                            homCon.titleController.text = runDataModel.title;
                            homCon.distanceController.text = runDataModel.distance.toString();
                            homCon.startDateController.text = DateFormat('h:mm a').format(runDataModel.startDate);
                            homCon.endDateController.text = DateFormat('h:mm a').format(runDataModel.endDate);

                            customDialog.recordDialog(
                              context: context,
                              titleText: CustomText.editRecord,
                              buttonText: "Update",
                              titleController: homCon.titleController,
                              distanceController: homCon.distanceController,
                              startDateController: homCon.startDateController,
                              endDateController: homCon.endDateController,
                              startDateValue: runDataModel.startDate,
                              endDateValue: runDataModel.endDate,
                              onTap: ()=> homCon.onCreateRecord(
                                isCreating: false,
                                runDataModel: runDataModel
                              ),
                            );
                          },
                          onTapDelete: (){
                            customDialog.removeItem(
                              context: context,
                              onTapNo: (){
                                Get.back();
                              },
                              onTapYes: (){
                                homCon.onDeleteRecord(recordId: runDataModel.id);
                              }
                            );
                          },
                        );
                      }
                    ) : Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Center(
                        child: Text(
                          "No Available Data",
                          style: CustomTextStyle.primary(textcolor: CustomTheme.colorDisabled),
                        ),
                      ),
                    );
                  default:
                  return Center(
                    child: Text("No Data yet"),
                  );
                }
              } 
                
              ),
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          homCon.clear();
          customDialog.recordDialog(
            context: context,
            titleText: "New Record",
            buttonText: "Create",
            titleController: homCon.titleController,
            distanceController: homCon.distanceController,
            startDateController: homCon.startDateController,
            endDateController: homCon.endDateController,
            startDateValue: null,
            endDateValue: null,
            onTap: ()=> homCon.onCreateRecord(
              isCreating: true,
              runDataModel: RunDataModel("", {}),
            ),
          );
        }, label: Text("Add Record"),
        backgroundColor: CustomTheme.colorPrimary,
        icon: Icon(Icons.add),
      ),
    );
  }
}