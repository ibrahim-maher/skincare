import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../app_colors.dart';
import '../../routes/app_routes.dart';
import '../../viewmodel/auth/sign_up_view_model.dart';
import '../components/custom_app_bar.dart';
import '../components/custom_button.dart';
import '../components/form_input_field.dart';

class SignUpView extends StatelessWidget {
  final SignUpViewModel viewModel = SignUpViewModel();

  void _continueAsDoctor(BuildContext context) {
    // Navigate to the Doctor SignUp Screen

    Get.offNamed(Routes.DOCTOR_SIGN_UP);

    // Navigator.pushNamed(context, '/doctorSignUp');
  }

  void _continueAsPatient(BuildContext context) {
    // Navigate to the Patient SignUp Screen

    Get.offNamed(Routes.PATIENT_SIGN_UP);

    // Navigator.pushNamed(context, '/patientSignUp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: 32,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 56),
            Form(
              key: viewModel.formKey,
              child: Column(
                children: <Widget>[
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
                  CustomButton(
                    text: 'Continue as Patient',
                    onPressed: () => _continueAsPatient(context),
                  ),
                  SizedBox(height: 12),
                  CustomButton(
                    text: 'Continue as Doctor',
                    backgroundColor: AppColors.secondaryColor,
                    onPressed: () => _continueAsDoctor(context),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(

                        'Already have an account?',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.tertiaryColor),

                      ),
                      GestureDetector(
                        onTap: viewModel.navigateToSignIn,
                        child: const Text(
                          ' Sign In',

                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
