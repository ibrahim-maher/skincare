import 'dart:async';
import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'onboarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => OnboardingScreen())), // Replace with your next screen class
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.pin_outlined, // Placeholder Icon
              size: 100.0,
              color: AppColors.whiteColor,
            ),
            SizedBox(height: 24),
            Text(
              'Skinny', // Your app name
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
            ),
            SizedBox(height: 12),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.quinaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
