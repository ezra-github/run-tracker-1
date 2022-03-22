import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:run_keeper/constants/constants.dart';
import 'package:run_keeper/pages/home/home_controller.dart';

import 'app_button_card.dart';
import 'app_text_field.dart';

class CustomDialog{

  final HomeController homCon = Get.find();

  recordDialog({BuildContext context, titleText, buttonText, TextEditingController titleController, TextEditingController distanceController, TextEditingController startDateController, TextEditingController endDateController, DateTime startDateValue, DateTime endDateValue, VoidCallback onTap}){
    Get.defaultDialog(
      title: titleText,
      titleStyle: CustomTextStyle.header(textcolor: CustomTheme.colorPrimary),
      content: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Record Title",
              style: CustomTextStyle.primary(),
            ),
            AppTextField(
              controller: titleController,
              hintText: "Title",
            ),
            SizedBox(height: 10,),
            Text(
              "Distance",
              style: CustomTextStyle.primary(),
            ),
            AppTextField(
              controller: distanceController,
              textInputType: TextInputType.number,
              hintText: "Enter distance in KM",
            ),
            SizedBox(height: 10,),
            Text(
              "Duration",
              style: CustomTextStyle.primary(),
            ),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: startDateController,
                    hintText: "Start",
                    onTap: () => homCon.selectStartDateAndEndDate(context, true),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: AppTextField(
                    controller: endDateController,
                    hintText: "End",
                    onTap: () => homCon.selectStartDateAndEndDate(context,false),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              height: 90,
              child: AppButtonCard(
                elevation: 1.0,
                titleFontSize: 20.0,
                title: buttonText,
                onTap: onTap
              ),
            ),
          ],
        ),
      ),
    );
  }


  void removeItem({BuildContext context, VoidCallback onTapNo, VoidCallback onTapYes}){
    Get.defaultDialog(
      title: CustomText.removeData,
      titleStyle: CustomTextStyle.header(textcolor: CustomTheme.colorPrimary),
      content: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Text(
              CustomText.removeContent,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onTapNo, 
                  child: Text(
                    "No",
                    style: CustomTextStyle.primary(textcolor: CustomTheme.colorDisabled),
                  ),
                ),
                TextButton(
                  onPressed: onTapYes, 
                  child: Text(
                    "Yes",
                    style: CustomTextStyle.primary(),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
    // var alertDialog = AlertDialog(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    //   title: Text(
    //     'REMOVE DATA',
    //     style: CustomTextStyle.header(),
    //   ),
    //   content: Text(
    //     'Are you sure you want to remove this data?'
    //   ),
    //   actions: <Widget>[
    //     new FlatButton(
    //       child: new Text(
    //         'No'
    //       ),
    //       onPressed: (){
    //       },
    //     ),
    //     new FlatButton(
    //       child: new Text(
    //         'Yes'
    //       ),
    //       onPressed: (){
    //       },
    //     ),
    //   ],
    // );
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context){
    //     return alertDialog;
    //   }
    // );
  }

}