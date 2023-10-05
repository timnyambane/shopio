import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/Auth/login_controller.dart';
import 'register.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.25),
                Image.asset("assets/app_logo.png", height: size.height * 0.1),
                const Text('Welcome back',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                const Text("Get back to your account"),
                SizedBox(height: size.height * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.emailCtr,
                        decoration: const InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.mail)),
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email cannot be empty';
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Invalid email format';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      Obx(
                        () => TextFormField(
                          controller: controller.passwordCtr,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: controller.toggleObscureText,
                              icon: Icon(
                                controller.obscureText.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          obscureText: controller.obscureText.value,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password cannot be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Obx(() => ElevatedButton(
                            onPressed: controller.loginUser,
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: controller.isLoggingIn.value
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Text(
                                      'Log In',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16),
                                    ),
                            )),
                          )),
                      SizedBox(height: size.height * 0.05),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            TextSpan(
                                text: "Sign up",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w900),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(() => const RegisterScreen());
                                  }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
