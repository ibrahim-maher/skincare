import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class SignUpViewModel {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

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

  void signUp() {
    if (formKey.currentState!.validate()) {
      // Perform the sign-up operation with the provided credentials
      // For example, using a FirebaseAuth instance:
      // FirebaseAuth.instance.createUserWithEmailAndPassword(
      //   email: emailController.text,
      //   password: passwordController.text,
      // );
    }
  }

  void navigateToSignIn() {
    Get.offNamed(Routes.SIGN_IN);
  }
}
