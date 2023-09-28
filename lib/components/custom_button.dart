import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;
  final FontWeight? textWeight;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;

  const CustomButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.prefixIcon,
      this.suffixIcon,
      this.prefixIconColor,
      this.suffixIconColor,
      this.borderColor,
      this.backgroundColor,
      this.textColor,
      this.textWeight,
      this.padding = const EdgeInsets.all(12.0),
      this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        foregroundColor: textColor ?? Colors.white,
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        side: borderColor != null ? BorderSide(color: borderColor!) : null,
      ),
      child: Padding(
        padding: padding!,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIcon != null)
              Icon(
                prefixIcon,
                color: prefixIconColor,
              ),
            if (prefixIcon != null) const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontWeight: textWeight ?? FontWeight.normal,
                  fontSize: fontSize),
            ),
            if (suffixIcon != null) const SizedBox(width: 8),
            if (suffixIcon != null)
              Icon(
                suffixIcon,
                color: suffixIconColor,
              ),
          ],
        ),
      ),
    );
  }
}
