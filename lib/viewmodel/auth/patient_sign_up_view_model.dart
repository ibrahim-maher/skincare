import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientSignUpViewModel {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name cannot be empty";
    }
    return null; // Valid name
  }

  String? validateEmail(String? value) {
    if (value == null || !value.contains('@')) {
      return "Enter a valid email";
    }
    return null; // Valid email
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null; // Valid password
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number cannot be empty";
    }
    // Additional checks can be added for phone number format
    return null; // Valid phone number
  }

  Future<void> signUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        // Firebase Authentication Sign-Up
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        String userId = userCredential.user!.uid;

        // Add additional user data to Firestore
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'phoneNumber': phoneNumberController.text.trim(),
          'role': 'patient',
          // Add other attributes as needed
        });

        // Success dialog or navigation
        _showSuccessDialog(context);
      } on FirebaseAuthException catch (e) {
        _showErrorDialog(context, "Firebase Auth Error: ${e.message}");
      } catch (e) {
        _showErrorDialog(context, "An unexpected error occurred: $e");
      }
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Registration Successful'),
        content: Text('You have successfully signed up.'),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.pushReplacementNamed(context, '/home'); // Replace with your home route
            },
          ),
        ],
      ),
    );
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

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
  }
}
