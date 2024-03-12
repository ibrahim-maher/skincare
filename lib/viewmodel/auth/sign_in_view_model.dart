import 'package:cloud_firestore/cloud_firestore.dart';
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
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // Assuming the users' roles are stored in a collection named 'users'
        // with the document ID equal to the user's UID
        // and that the role is stored in a field named 'role'
        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;
          DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

          if (userDoc.exists) {
            String role = userDoc.get('role');
            if (role == 'doctor') {
              Get.offNamed('/DoctorScreen'); // Navigate to the doctor's screen
            } else if (role == 'patient') {
              Get.offNamed('/PatientScreen'); // Navigate to the patient's screen
            } else {
              _showErrorDialog(context, 'Your role is not defined. Contact support.');
            }
          } else {
            _showErrorDialog(context, 'User data not found. Contact support.');
          }
        }
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
