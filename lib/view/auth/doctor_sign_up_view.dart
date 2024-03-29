import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_colors.dart';
import '../../viewmodel/auth/doctor_sign_up_view_model.dart';
import '../components/custom_app_bar.dart';
import '../components/custom_button.dart';
import '../components/form_input_field.dart';

class DoctorSignUpView extends StatelessWidget {
  final DoctorSignUpViewModel viewModel = DoctorSignUpViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Doctor Sign Up'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildHeaderText(),
                SizedBox(height: 30),
                FormInputField(
                  controller: viewModel.nameController,
                  label: 'Full Name',
                  keyboardType: TextInputType.name,
                  validator: viewModel.validateName,
                ),
                SizedBox(height: 16),
                FormInputField(
                  controller: viewModel.emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: viewModel.validateEmail,
                ),
                SizedBox(height: 16),
                FormInputField(
                  controller: viewModel.passwordController,
                  label: 'Password',
                  keyboardType: TextInputType.text,
                  validator: viewModel.validatePassword,
                  isPassword: true,
                ),
                SizedBox(height: 24),
                FormInputField(
                  controller: viewModel.specializationController,
                  label: 'Specialization',
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 16),
                FormInputField(
                  controller: viewModel.licenseNumberController,
                  label: 'License Number',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 24),
                CustomButton(
                  text: 'Sign Up',
                  onPressed: viewModel.signUp,
                ),
                SizedBox(height: 20),
                _buildSignInPrompt(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Text(
      "Join as a Doctor",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSignInPrompt(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.offAllNamed('/signIn'); // Navigate the user to the login screen after logging out
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Already have an account? ',
          style: TextStyle(color: AppColors.secondaryColor),
          children: [
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
