import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:run_tracker/components/app_custom_card.dart';
import 'package:run_tracker/components/app_custom_dialog.dart';
import 'package:run_tracker/constants/constants.dart';
import 'package:run_tracker/pages/home/home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({ Key key }) : super(key: key);

  final HomeController homCon = Get.put(HomeController());

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
              icon: Icon(Icons.power_settings_new), onPressed: (){

              }
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        // margin: const EdgeInsets.all(20),
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
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 20,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, i){
                return CustomCard(
                  month: "Mar",
                  date: "31",
                  title: "Relaxed Run",
                  distance: 21.0,
                  start: "1:30 pm",
                  end: "2:00 pm",
                  onTapEdit: (){
                    customDialog.recordDialog(
                      context: context,
                      titleText: "Edit Record",
                      buttonText: "Update",
                      titleController: homCon.titleController,
                      distanceController: homCon.distanceController,
                      startDateController: homCon.startDateController,
                      endDateController: homCon.endDateController,
                      startDateValue: null,
                      endDateValue: null,
                      onTap: ()=> homCon.onCreateRecord(),
                    );
                  },
                  onTapDelete: (){
                    customDialog.removeItem(
                      context: context,
                      onTapNo: (){
                        
                      },
                      onTapYes: (){
                        
                      }
                    );
                  },
                );
              }
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          homCon.titleController.text = "";
          homCon.distanceController.text = "";
          homCon.startDateController.text = "";
          homCon.endDateController.text = "";
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
            onTap: ()=> homCon.onCreateRecord(),
          );
        }, label: Text("Add Record"),
        backgroundColor: CustomTheme.colorPrimary,
        icon: Icon(Icons.add),
      ),
    );
  }
}