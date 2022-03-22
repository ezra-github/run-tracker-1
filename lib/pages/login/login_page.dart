import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:run_keeper/components/app_button_card.dart';
import 'package:run_keeper/constants/constants.dart';
import 'package:run_keeper/pages/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({ Key key }) : super(key: key);

  final LoginController logCon = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/app_icon.png')
                  )
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  CustomText.title,
                  style: CustomTextStyle.primary(textweight: FontWeight.bold, textsize: 25.0),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        child: AppButtonCard(
          elevation: 1.0,
          titleFontSize: 20.0,
          title: "Sign In",
          onTap: () => logCon.login()
        ),
      ),
    );
  }
}