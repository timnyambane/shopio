import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import 'parties_controller.dart';

class AddPartyController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameCtr = TextEditingController();
  final phoneCtr = TextEditingController();
  final selectedRole = RxString('Customer');
  final isRoleSelected = RxBool(false);
  final isCreating = false.obs;

  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  void setSelectedRole(String role) {
    selectedRole.value = role;
    isRoleSelected.value = true;
  }

  Future<void> submitParty() async {
    if (formKey.currentState!.validate()) {
      isCreating.value = true;
      try {
        final url = Uri.parse(Constants.partiesEndpoint);
        final response = await http.post(
          url,
          body: {
            'name': capitalize(nameCtr.text),
            'phone': phoneCtr.text,
            'role': selectedRole.value,
          },
        );

        if (response.statusCode == 201) {
          final partiesController = Get.find<PartiesController>();
          partiesController.fetchParties();

          nameCtr.clear();
          phoneCtr.clear();
          selectedRole.value = 'Customer';

          isCreating.value = false;
          print('Success');
          Get.back();
        } else {
          print('Failed to create party. Status code: ${response.statusCode}');
          isCreating.value = false;
        }
      } catch (e) {
        print('Error creating party: $e');
        isCreating.value = false;
      }
    }
  }

  @override
  void dispose() {
    nameCtr.dispose();
    phoneCtr.dispose();
    super.dispose();
  }
}
