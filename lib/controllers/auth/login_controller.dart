import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopio/views/Home/home.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailCtr = TextEditingController();
  final passwordCtr = TextEditingController();
  var obscureText = true.obs;
  var isLoggingIn = false.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void loginUser() {
    if (formKey.currentState!.validate()) {
      Get.to(() => const HomeScreen());
    }
  }
}
