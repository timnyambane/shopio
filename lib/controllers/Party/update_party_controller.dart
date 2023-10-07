import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../models/party.dart';
import '../../utils/constants.dart';
import 'parties_controller.dart';

class UpdatePartyController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameCtr = TextEditingController();
  final phoneCtr = TextEditingController();
  final selectedRole = RxString('Customer');
  final isRoleSelected = RxBool(false);
  final isUpdating = false.obs;

  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  void setSelectedRole(String role) {
    selectedRole.value = role;
    isRoleSelected.value = true;
  }

  Future<void> updateParty(int partyId) async {
    if (formKey.currentState!.validate()) {
      isUpdating.value = true;

      try {
        final party = PartyModel(
          id: partyId,
          name: capitalize(nameCtr.text),
          phone: phoneCtr.text,
          role: selectedRole.value,
        );

        final response = await http.patch(
            Uri.parse('${Constants.partiesEndpoint}/$partyId/'),
            body: party.toMap());

        if (response.statusCode == 200) {
          final partiesController = Get.find<PartiesController>();
          partiesController.fetchParties();

          nameCtr.clear();
          phoneCtr.clear();
          selectedRole.value = 'Customer';

          isUpdating.value = false;
          Fluttertoast.showToast(
              msg: 'Succesfully updated the party',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white);
          Get.back();
        } else {
          Fluttertoast.showToast(
              msg:
                  'Failed to update party. Status code: ${response.statusCode}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white);
          isUpdating.value = false;
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: 'Error updating party: $e',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white);
        isUpdating.value = false;
      }
    }
  }

  Future<void> deleteParty(int partyId) async {
    bool confirmed = await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this party?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed) {
      try {
        final response = await http.delete(
          Uri.parse('${Constants.partiesEndpoint}/$partyId/'),
        );

        if (response.statusCode == 204) {
          final partiesController = Get.find<PartiesController>();
          partiesController.fetchParties();

          Fluttertoast.showToast(
            msg: 'Successfully deleted the party',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          Get.back();
        } else {
          Fluttertoast.showToast(
            msg: 'Failed to delete party. Status code: ${response.statusCode}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Error deleting party: $e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }
}
