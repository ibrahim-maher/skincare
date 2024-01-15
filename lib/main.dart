import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skincare/routes/app_pages.dart';
import 'package:skincare/routes/app_routes.dart';
import 'package:skincare/view/auth/sign_in_screen.dart';
import 'package:skincare/view/auth/sign_up_screen.dart';
import 'package:skincare/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Application',
      initialRoute: Routes.SPLASH,
      getPages: AppPages.pages,
      // Define other properties as needed
    );
  }
}

