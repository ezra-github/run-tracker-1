import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:run_keeper/pages/home/home_controller.dart';
import 'package:run_keeper/pages/home/home_page.dart';
import 'package:run_keeper/pages/login/login_page.dart';
import 'package:run_keeper/pages/login/login_service.dart';

class LoginController extends GetxController{
  final LoginService logService = LoginService();
  User user = FirebaseAuth.instance.currentUser;

  login() async {
    var result = await logService.signInAnon();

    if(result == null){
      Get.snackbar("Error", "Please try again later");
    }else{
      user = result;
      Get.to(() => HomePage());
    }
  }

  signOutUser() async{
    await logService.signOut();
    Get.to(() => LoginPage());
  }
}