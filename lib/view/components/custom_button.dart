import 'package:flutter/material.dart';
import '../../app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Function(BuildContext) onPressed;

  CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = AppColors.whiteColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        onPrimary: textColor,
      ),
      onPressed: () => onPressed(context),
      child: Text(text),
    );
  }
}
