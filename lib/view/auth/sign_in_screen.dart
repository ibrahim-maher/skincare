import 'package:flutter/material.dart';

import '../../app_colors.dart';
import '../../viewmodel/auth/sign_in_view_model.dart';
import '../components/custom_button.dart';
import '../components/form_input_field.dart';

class SignInView extends StatelessWidget {
  final SignInViewModel viewModel = SignInViewModel();

  SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
                child: Text(
              "Sign In",
              style: TextStyle(
                  fontSize: 32,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold),
            )),
            const SizedBox(
              height: 56,
            ),
            Form(
              key: viewModel.formKey,
              child: Column(
                children: <Widget>[
                  FormInputField(
                    controller: viewModel.emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: viewModel.validateEmail,
                  ),
                  const SizedBox(height: 16),
                  FormInputField(
                    controller: viewModel.passwordController,
                    label: 'Password',
                    keyboardType: TextInputType.text,
                    validator: viewModel.validatePassword,
                    isPassword: true,
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Sign In',
                    onPressed: viewModel.signIn,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(

                          'Don\'t have an account?',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.tertiaryColor),

                      ),
                      GestureDetector(
                        onTap: viewModel.navigateToSignUp,
                        child: const Text(
                          ' Sign Up',

                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: viewModel.forgotPassword,
                    child: const Text(
                      'Forgot Password?',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.quaternaryColor),
                    ),
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
