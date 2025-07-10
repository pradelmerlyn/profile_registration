import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final double? width;
  final bool useFullWidth;

  const CustomRoundedButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
    this.width,
    this.useFullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: borderColor != null
              ? BorderSide(color: borderColor!)
              : BorderSide.none,
        ),
        textStyle: const TextStyle(fontSize: 16),
        elevation: 0,
      ),
      child: Text(label),
    );

    if (width != null) {
      return SizedBox(width: width, child: button);
    } else if (useFullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    } else {
      return button;
    }
  }
}
