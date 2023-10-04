import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login.dart';
import 'register.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => LaunchScreenState();
}

class LaunchScreenState extends State<LaunchScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset("assets/app_logo.png", width: 150),
            SizedBox(height: size.height * 0.3),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const LoginScreen());
                },
                child: const Center(
                    child: Text("Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 16)))),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const RegisterScreen());
                },
                child: const Center(
                    child: Text("Create Account",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 16))))
          ],
        ),
      ),
    );
  }
}
