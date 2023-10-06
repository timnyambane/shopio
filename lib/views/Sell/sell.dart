import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopio/controllers/Sell/sell_controller.dart';

class SellScreen extends StatelessWidget {
  final controller = Get.put(SellController());
  SellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: const Text("Select Customers"), centerTitle: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                      controller: controller.searchCtr,
                      decoration: const InputDecoration(
                          hintText: 'Search Customers...',
                          prefixIcon: Icon(Icons.search))),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListTile(
                      visualDensity: VisualDensity.compact,
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/prod_image.png"),
                      ),
                      title: Text("Walk-in Customer"),
                      subtitle: Text("Guest"),
                    ))
              ],
            ),
          ),
        ));
  }
}
