import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../routes/app_routes.dart';

class SignInViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  Future<void> signIn(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        // Navigate to the next screen after successful sign-in
        Get.offNamed('/HomeScreen'); // Replace with your next screen route
      } on FirebaseAuthException catch (e) {
        _showErrorDialog(context, e.message ?? 'An error occurred during sign in.');
      }
    }
  }

  void navigateToSignUp() {
    Get.offNamed(Routes.SIGN_UP);
  }

  Future<void> forgotPassword(BuildContext context) async {
    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      _showErrorDialog(context, 'Please enter a valid email.');
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      _showSuccessDialog(context, 'Password reset email sent. Please check your email.');
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(context, e.message ?? 'An error occurred during password reset.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Success'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
