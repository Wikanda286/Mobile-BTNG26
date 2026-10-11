import 'package:flutter/material.dart';
import 'package:movieapp/ui/colors.dart';

class ReuseSocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  const ReuseSocialButton({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          color: buttonGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: child),
      ),
    );
  }
}