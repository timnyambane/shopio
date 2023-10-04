import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/Party/update_party_controller.dart';
import '../../models/party.dart';

class UpdatePartyScreen extends StatelessWidget {
  final Party party;
  final _controller = Get.put(UpdatePartyController());

  UpdatePartyScreen({super.key, required this.party}) {
    _controller.nameCtr.text = party.name;
    _controller.phoneCtr.text = party.phone;
    _controller.setSelectedRole(party.role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Party'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _controller.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _controller.nameCtr,
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
                          controller: _controller.phoneCtr,
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
                                              _controller.selectedRole.value,
                                          onChanged: (value) => _controller
                                              .setSelectedRole(value!),
                                        ),
                                      ),
                                      Expanded(
                                        child: RadioListTile(
                                          title: const Text('Supplier'),
                                          value: 'Supplier',
                                          groupValue:
                                              _controller.selectedRole.value,
                                          onChanged: (value) => _controller
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
                              _controller.updateParty(party.id!);
                            },
                            child: _controller.isUpdating.value
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
