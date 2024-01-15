import 'package:flutter/material.dart';
import '../../app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
    );
  }
}
