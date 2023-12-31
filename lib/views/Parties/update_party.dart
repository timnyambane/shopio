import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/Party/update_party_controller.dart';
import '../../models/party.dart';

class UpdatePartyScreen extends StatelessWidget {
  final PartyModel party;
  final controller = Get.put(UpdatePartyController());

  UpdatePartyScreen({super.key, required this.party}) {
    controller.nameCtr.text = party.name;
    controller.phoneCtr.text = party.phone;
    controller.setSelectedRole(party.role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Party'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                controller.deleteParty(party.id!);
              },
              icon: Icon(Icons.delete, color: Colors.red[800]),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controller.nameCtr,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.account_circle),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: controller.phoneCtr,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a phone number';
                            }
                            return null;
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Select Role"),
                          ),
                          Obx(() => Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: RadioListTile(
                                          title: const Text('Customer'),
                                          value: 'Customer',
                                          groupValue:
                                              controller.selectedRole.value,
                                          onChanged: (value) => controller
                                              .setSelectedRole(value!),
                                        ),
                                      ),
                                      Expanded(
                                        child: RadioListTile(
                                          title: const Text('Supplier'),
                                          value: 'Supplier',
                                          groupValue:
                                              controller.selectedRole.value,
                                          onChanged: (value) => controller
                                              .setSelectedRole(value!),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      ),
                      Obx(() => ElevatedButton(
                            onPressed: () {
                              controller.updateParty(party.id!);
                            },
                            child: controller.isUpdating.value
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator())
                                : const Text('Update'),
                          ))
                    ],
                  ),
                ))));
  }
}
