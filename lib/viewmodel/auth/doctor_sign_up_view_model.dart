import 'package:flutter/material.dart';

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

  void signUp() {
    if (formKey.currentState!.validate()) {
      // Implement the sign-up logic
      // This might involve sending data to a backend or using an authentication service
      // Example: AuthService.signUpDoctor(name, email, password, specialization, licenseNumber)
    }
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    specializationController.dispose();
    licenseNumberController.dispose();
  }
}
