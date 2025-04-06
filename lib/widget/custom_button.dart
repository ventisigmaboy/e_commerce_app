import 'package:e_commerce_app/config/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget? icon, rightIcon;
  final EdgeInsetsGeometry padding;
  final void Function()? onPressed;
  final String text;
  final Color? color; // Background color (null for outline)
  final Color? textColor;
  final Color borderColor; // New parameter
  final bool isOutlined; // New parameter

  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.color,
    this.padding = const EdgeInsets.all(0),
    this.textColor,
    this.icon,
    this.borderColor = AppColors.primary100, // Default border color
    this.isOutlined = false, this.rightIcon, // Default to filled button
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? Colors.transparent : color,
          foregroundColor: isOutlined ? borderColor : textColor,
          side: isOutlined ? BorderSide(color: borderColor, width: 1) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size(double.infinity, 55),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) 
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SizedBox(child: icon),
              ),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (rightIcon != null) 
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SizedBox(child: rightIcon),
              ),
          ],
        ),
      ),
    );
  }
}
