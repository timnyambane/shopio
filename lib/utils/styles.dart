import 'package:flutter/material.dart';

class AppStyles {
  static const Color primaryColor = Color(0xFF3B1E05);
  static const Color secondaryColor = Color(0xFFF57E20);

  static const TextStyle displayText =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor);

  static const TextStyle headerText =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor);

  static const TextStyle bodyLBoldText =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor);

  static const TextStyle bodyLText =
      TextStyle(fontSize: 16, color: primaryColor);

  static const TextStyle bodyBoldText =
      TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: primaryColor);

  static const TextStyle bodyText =
      TextStyle(fontSize: 14, color: secondaryColor);
}
