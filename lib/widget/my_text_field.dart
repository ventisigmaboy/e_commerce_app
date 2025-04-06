import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final Widget? suffix;
  final TextEditingController? controller;
  final bool? obscureText;
  final String title, hintText;
  const MyTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.obscureText,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w500, height: 2)),
        TextField(
          obscureText: obscureText ?? false,
          controller: controller,
          style: TextStyle(fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            suffix: suffix,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 14),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}
