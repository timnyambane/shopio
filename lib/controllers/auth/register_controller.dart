import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final passwordCtr = TextEditingController();
  final cpasswordCtr = TextEditingController();
  final phoneCtr = TextEditingController();

  var obscureText = true.obs;
  var isCreatingAccount = false.obs;

  void toggleObscureText() {
    obscureText.toggle();
  }
}
