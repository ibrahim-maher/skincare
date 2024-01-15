import 'package:flutter/material.dart';
import '../../app_colors.dart';

class FormInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isPassword;

  FormInputField({
    Key? key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondaryColor),
          borderRadius: BorderRadius.circular(18.0), // Adjust border radius
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(18.0), // Adjust border radius
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor),
          borderRadius: BorderRadius.circular(18.0), // Adjust border radius
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor),
          borderRadius: BorderRadius.circular(18.0), // Adjust border radius
        ),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            Icons.visibility,
          ),
          onPressed: () {
            // Toggle password visibility logic here
          },
        )
            : null,
      ),
      keyboardType: keyboardType,
      obscureText: isPassword,
      validator: validator,
    );
  }
}
