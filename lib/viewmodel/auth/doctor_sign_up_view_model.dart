import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorSignUpViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController licenseNumberController = TextEditingController();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name cannot be empty";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || !value.contains('@')) {
      return "Enter a valid email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  String? validateSpecialization(String? value) {
    if (value == null || value.isEmpty) {
      return "Specialization cannot be empty";
    }
    return null;
  }

  String? validateLicenseNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "License number cannot be empty";
    }
    return null;
  }

  Future<void> signUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        String userId = userCredential.user!.uid;

        await FirebaseFirestore.instance.collection('doctors').doc(userId).set({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'specialization': specializationController.text.trim(),
          'licenseNumber': licenseNumberController.text.trim(),
          'role': 'doctor',
        });

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
        content: Text('You have successfully signed up as a doctor.'),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.pushReplacementNamed(context, '/doctorDashboard'); // Replace with your doctor dashboard route
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
    specializationController.dispose();
    licenseNumberController.dispose();
  }
}
