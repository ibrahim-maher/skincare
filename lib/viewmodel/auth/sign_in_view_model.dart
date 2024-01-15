import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class SignInViewModel {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!value.contains('@')) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void signIn() {
    if (formKey.currentState!.validate()) {
      // Perform the sign-in operation with the provided credentials
      // For example, using a FirebaseAuth instance:
      // FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: emailController.text,
      //   password: passwordController.text,
      // );
    }
  }

  void navigateToSignUp() {
    Get.offNamed(Routes.SIGN_UP);

  }

  void forgotPassword() {
    // Implement forgot password functionality
    // For example, sending a password reset email:
    // FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
  }
}
