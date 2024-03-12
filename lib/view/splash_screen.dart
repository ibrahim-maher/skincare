import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'home_screen.dart';
import 'onboarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigateUser());
  }

  void _navigateUser() {
    // Check if user is signed in
    if (FirebaseAuth.instance.currentUser != null) {
      // If the user is signed in, navigate to the HomeScreen
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(), // Replace HomeScreen with your home screen widget
      ));
    } else {
      // If the user is not signed in, navigate to OnboardingScreen after a delay
      Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => OnboardingScreen())),
      );
    }
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
