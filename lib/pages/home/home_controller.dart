import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:run_keeper/components/app_button_card.dart';
import 'package:run_keeper/components/app_text_field.dart';
import 'package:run_keeper/constants/constants.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:run_keeper/model/run_data.dart';
import 'package:run_keeper/pages/home/home_service.dart';
import 'package:run_keeper/pages/login/login_controller.dart';
import 'package:run_keeper/pages/login/login_service.dart';

class HomeController extends GetxController{
  final TextEditingController titleController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final LoginController logCon = Get.find();
  final HomeService firebaseData = HomeService();

  Rx<List<RunDataModel>> runDataList = Rx<List<RunDataModel>>();
  var isFetching = true.obs;

  List<RunDataModel> get runDatas => runDataList.value;
  RunDataModel runData = RunDataModel("", {});
  DateTime startDateValue;
  DateTime endDateValue;

  @override
  void onInit() {
    super.onInit();
    runDataList.bindStream(firebaseData.runDataStream(logCon.user.uid)); //stream coming from firebase
    getData();
  }
  
  clear(){
    titleController.text = "";
    distanceController.text = "";
    startDateController.text = "";
    endDateController.text = "";
  }

  getData() async {
    try{
      var runData = await firebaseData.getRunList(logCon.user.uid);
    }finally{
      print("finally");
      isFetching.value = false;
    }
  }


  Future<void> onCreateRecord({bool isCreating, RunDataModel runDataModel}) async {

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

    runData.title = titleController.text;
    runData.distance = double.parse(distanceController.text);
    runData.startDate = startDateValue;
    runData.endDate = endDateValue;
    runData.dateCreated = isCreating ? DateTime.now() : runDataModel.dateCreated;
    if(isCreating){
      try {
        await firebaseData.addRunData(logCon.user.uid ,runData.updateRunData());
      } finally {
        Get.back();
        Get.snackbar("Success", "Run data added successfully", backgroundColor: CustomTheme.colorWhite);
        runDataList.bindStream(firebaseData.runDataStream(logCon.user.uid));
      } 
    }else{
      try {
        await firebaseData.updateRunData(logCon.user.uid, runDataModel.id, runData.updateRunData());
      } finally {
        Get.back();
        Get.snackbar("Success", "Run data updated successfully", backgroundColor: CustomTheme.colorWhite);
      } 
    }
  }

  Future<void> onDeleteRecord({String recordId}) async {
    try{
      await firebaseData.deleteRunData(logCon.user.uid, recordId);
    }finally{
      Get.back();
      Get.snackbar("Success", "Run data deleted successfully", backgroundColor: CustomTheme.colorWhite);
    }
  }

  void selectStartDateAndEndDate(BuildContext context, bool isStartDate){
    FocusScope.of(context).requestFocus(FocusNode());
    DatePicker.showDatePicker(
      context,
      dateFormat: "MMM dd HH:mm",
      minDateTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0,0),
      maxDateTime: DateTime(2101),
      onConfirm: (date, list) {
        if(isStartDate){
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