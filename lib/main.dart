import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:run_keeper/pages/home/home_page.dart';
import 'package:run_keeper/pages/login/login_controller.dart';
import 'package:run_keeper/pages/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final LoginController logCon = Get.put(LoginController());
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Run Keeper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: logCon.user == null ? LoginPage() : HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
