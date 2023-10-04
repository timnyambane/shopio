import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/Auth/launch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF013047),
        useMaterial3: true,
        elevatedButtonTheme: const ElevatedButtonThemeData(),
      ),
      home: const LaunchScreen(),
    );
  }
}
