import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/Party/add_party_controller.dart';

class AddPartyScreen extends StatelessWidget {
  final _controller = Get.put(AddPartyController());

  AddPartyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Party"),
        shadowColor: null,
        elevation: 0,
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
                                    groupValue: _controller.selectedRole.value,
                                    onChanged: (value) =>
                                        _controller.setSelectedRole(value!),
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    title: const Text('Supplier'),
                                    value: 'Supplier',
                                    groupValue: _controller.selectedRole.value,
                                    onChanged: (value) =>
                                        _controller.setSelectedRole(value!),
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
                        _controller.submitParty();
                      },
                      child: _controller.isCreating.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator())
                          : const Text('Create'),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
