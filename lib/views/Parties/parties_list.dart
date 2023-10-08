import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/Party/parties_controller.dart';
import 'add_party.dart';
import 'update_party.dart';

class PartiesScreen extends StatelessWidget {
  final controller = Get.put(PartiesController());

  PartiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Obx(() {
            return controller.isSearching.value
                ? TextField(
                    controller: controller.searchController,
                    onChanged: controller.filterParties,
                    decoration: const InputDecoration(
                      hintText: 'Search Parties...',
                    ),
                    focusNode: controller.searchFocusNode,
                    autofocus: true,
                  )
                : const Text("Parties");
          }),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Obx(() {
                return Icon(
                    controller.isSearching.value ? Icons.close : Icons.search);
              }),
              onPressed: () {
                controller.searchController.clear();
                controller.filterParties('');
                controller.toggleSearch();
                if (controller.isSearching.value) {
                  controller.searchFocusNode.requestFocus();
                } else {
                  controller.searchFocusNode.unfocus();
                }
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.person_add_alt_1,
              ),
              onPressed: () {
                Navigator.of(context).push(_createRoute());
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return const CircularProgressIndicator();
              } else if (controller.filteredParties.isEmpty) {
                return const Text('No Parties');
              } else {
                return Expanded(
                  child: RefreshIndicator(
                      onRefresh: controller.fetchParties,
                      child: ListView.separated(
                        itemCount: controller.filteredParties.length,
                        itemBuilder: (context, index) {
                          final party = controller.filteredParties[index];
                          return Dismissible(
                            key: Key(party.id.toString()),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              if (direction == DismissDirection.startToEnd) {
                                controller.makePhoneCall(party.phone);
                              }
                            },
                            background: Container(
                              color: Colors.green,
                              alignment: Alignment.centerLeft,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Call",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            child: ListTile(
                              onTap: () {
                                Get.to(() => UpdatePartyScreen(party: party));
                              },
                              leading:
                                  const CircleAvatar(child: Icon(Icons.person)),
                              title: Text(party.name),
                              subtitle: Text(
                                party.phone,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              trailing: Text(party.role),
                              visualDensity: VisualDensity.compact,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const Divider(height: 0, thickness: 0),
                      )),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  PageRouteBuilder _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AddPartyScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
