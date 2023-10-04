import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: [
        SizedBox(height: size.height * 0.15),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: size.height * 0.025),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.nameCtr,
                        decoration: const InputDecoration(
                            labelText: "Username",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.account_circle)),
                        keyboardType: TextInputType.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username cannot be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      TextFormField(
                        controller: controller.emailCtr,
                        decoration: const InputDecoration(
                            labelText: "E-mail",
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
                      TextFormField(
                        controller: controller.passwordCtr,
                        decoration: const InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock)),
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password cannot be empty';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          } else if (!value.contains(RegExp(r'[A-Z]'))) {
                            return 'Password must contain at least one uppercase letter';
                          } else if (!value.contains(RegExp(r'[a-z]'))) {
                            return 'Password must contain at least one lowercase letter';
                          } else if (!value.contains(RegExp(r'[0-9]'))) {
                            return 'Password must contain at least one numeric digit';
                          } else if (!value.contains(RegExp(r'[!@\$&*~]'))) {
                            return 'Password must contain at least one special character';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      Obx(
                        () => TextFormField(
                          controller: controller.cpasswordCtr,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
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
                            if (controller.passwordCtr.text !=
                                controller.passwordCtr.text) {
                              return 'Passwords are not similar';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Obx(() => ElevatedButton(
                      onPressed: () {},
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: controller.isCreatingAccount.value
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(),
                              )
                            : const Text(
                                'Create Account',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 16),
                              ),
                      )),
                    ))
              ],
            ),
          ),
        )
      ])),
    );
  }
}
