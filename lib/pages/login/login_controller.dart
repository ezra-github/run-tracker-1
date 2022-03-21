import 'package:get/get.dart';
import 'package:run_tracker/pages/home/home_page.dart';

class LoginController extends GetxController{


  login(){
    Get.to(() => HomePage());
  }
}