import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/party.dart';
import '../../utils/constants.dart';
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
        final party = Party(
          name: capitalize(nameCtr.text),
          phone: phoneCtr.text,
          role: selectedRole.value,
        );

        final response = await http.post(Uri.parse(Constants.partiesEndpoint),
            body: party.toMap());

        if (response.statusCode == 201) {
          final partiesController = Get.find<PartiesController>();
          partiesController.fetchParties();

          nameCtr.clear();
          phoneCtr.clear();
          selectedRole.value = 'Customer';

          isCreating.value = false;
          Fluttertoast.showToast(
              msg: "Added product succesfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.green,
              textColor: Colors.white);
          Get.back();
        } else {
          Fluttertoast.showToast(
              msg:
                  'Failed to create party. Status code: ${response.statusCode}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white);
          isCreating.value = false;
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: 'Error creating party: $e',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white);

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
