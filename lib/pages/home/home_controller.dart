import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:run_tracker/components/app_button_card.dart';
import 'package:run_tracker/components/app_text_field.dart';
import 'package:run_tracker/constants/constants.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:run_tracker/model/run_data.dart';

class HomeController extends GetxController{
  final TextEditingController titleController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  RunDatamodel runData = RunDatamodel("", {});
  DateTime startDateValue;
  DateTime endDateValue;

  void onCreateRecord(){

    if(titleController.text == ""){
      return Get.snackbar("Error", "Please add title", backgroundColor: CustomTheme.colorWhite);
    }

    if(distanceController.text == ""){
      return Get.snackbar("Error", "Please add distance", backgroundColor: CustomTheme.colorWhite);
    }

    if(startDateController.text == ""){
      return Get.snackbar("Error", "Please add start date", backgroundColor: CustomTheme.colorWhite);
    }

    if(endDateController.text == ""){
      return Get.snackbar("Error", "Please add end date", backgroundColor: CustomTheme.colorWhite);
    }



  }

  void selectStartDateAndEndDate(BuildContext context){
    FocusScope.of(context).requestFocus(FocusNode());
    DatePicker.showDatePicker(
      context,
      dateFormat: "MMM dd HH:mm",
      minDateTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0,0),
      maxDateTime: DateTime(2101),
      onConfirm: (date, list) {
        if(startDateController.text == ""){
          startDateController.text = DateFormat('h:mm a').format(date);
          startDateValue = date;
        }else{
          endDateController.text = DateFormat('h:mm a').format(date);
          endDateValue = date;
        }
      },
      pickerMode: DateTimePickerMode.datetime,
    );
  }


}