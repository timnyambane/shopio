import 'package:flutter/material.dart';

class AppStyles {
  // Colors
  static const Color primaryColor = Color(0xFF001524);
  static const Color secondaryColor = Color(0xFFFF7D00);

  static const Color successColor = Color(0xFF9BF19E);
  static const Color errorColor = Color(0xFFEB9C97);
  static const Color infoColor = Color(0xFF9CCBF1);

  // Default Material Design Color Schemes
  static const MaterialColor primaryMaterialColor = MaterialColor(
    0xFF001524,
    <int, Color>{
      50: Color(0xFFE5EAF0),
      100: Color(0xFFBAC9D6),
      200: Color(0xFF8EABB9),
      300: Color(0xFF628E9C),
      400: Color(0xFF3C7586),
      500: Color(0xFF16626F),
      600: Color(0xFF135965),
      700: Color(0xFF104D5C),
      800: Color(0xFF0E4352),
      900: Color(0xFF082E41),
    },
  );

  // Text Styles
  static const TextStyle pageTitleStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static const TextStyle sectionTitleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static const TextStyle subTitleStyle = TextStyle(
    fontSize: 20,
    color: secondaryColor,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle smallTextStyle = TextStyle(
    fontSize: 12,
    color: secondaryColor,
  );
}
