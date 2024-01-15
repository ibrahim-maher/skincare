import 'package:flutter/material.dart';

class PatientSignUpViewModel {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  String? validateName(String? value) => value!.isEmpty ? "Name cannot be empty" : null;
  String? validateEmail(String? value) => !value!.contains('@') ? "Enter a valid email" : null;
  String? validatePassword(String? value) => value!.length < 6 ? "Password must be at least 6 characters" : null;
  String? validatePhoneNumber(String? value) => value!.isEmpty ? "Phone number cannot be empty" : null;

  void signUp() {
    if (formKey.currentState!.validate()) {
      // Implement sign-up logic, possibly using a user service or authentication provider
      // Example: UserService.signUpPatient(name, email, password, phoneNumber)
    }
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
  }
}
