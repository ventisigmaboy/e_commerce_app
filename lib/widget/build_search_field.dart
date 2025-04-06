import 'package:e_commerce_app/config/constants.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  const SearchField({super.key, this.controller, this.onTap, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 14),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/icons/search.png',
            width: 20,
            color: AppColors.primary300,
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/icons/mic.png',
            width: 20,
            color: AppColors.primary300,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.primary400),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary100),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary200),
          borderRadius: BorderRadius.circular(10),
        ),
        isDense: true,
      ),
      onTap: onTap,
    );
  }
}
