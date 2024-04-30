import 'package:ecommerce_client/controllers/home_controller.dart';
import 'package:ecommerce_client/controllers/login_controller.dart';
import 'package:ecommerce_client/firebase_options.dart';
import 'package:ecommerce_client/pages/home_page.dart';
import 'package:ecommerce_client/pages/login_page.dart';
import 'package:ecommerce_client/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main()async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);
  Get.put(LoginController());
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RegisterPage()
    );
  }
}

