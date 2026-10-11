import 'package:flutter/material.dart';
import 'package:movieapp/ui/colors.dart';
import 'package:movieapp/ui/typography.dart';

class ReuseTextfieldAuth extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  ReuseTextfieldAuth({
    super.key,
    this.obscureText = false,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: sRegular.copyWith(color: white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: sRegular.copyWith(color: white.withValues(alpha: 0.8)),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        hintStyle: sRegular.copyWith(color: grey),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: 0.7),
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 1.5),
        ),
      ),
    );
  }
}