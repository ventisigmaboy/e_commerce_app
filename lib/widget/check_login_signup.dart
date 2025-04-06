import 'package:e_commerce_app/config/constants.dart';
import 'package:flutter/material.dart';

class CheckLogInSignUp extends StatelessWidget {
  final MainAxisAlignment? mainAxisAlignment;
  final String firText, secText;
  final void Function()? onTap;
  const CheckLogInSignUp({
    super.key,
    this.onTap,
    required this.firText,
    required this.secText,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        Text(
          firText,
          style: TextStyle(color: AppColors.primary500, letterSpacing: -0.2),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            secText,
            style: TextStyle(
              color: AppColors.primary900,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              letterSpacing: -0.2,
            ),
          ),
        ),
      ],
    );
  }
}
