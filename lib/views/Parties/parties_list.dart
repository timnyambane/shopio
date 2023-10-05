import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/Party/parties_controller.dart';
import 'add_party.dart';
import 'update_party.dart';

class PartiesScreen extends StatelessWidget {
  final _controller = Get.put(PartiesController());

  PartiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Obx(() {
            return _controller.isSearching.value
                ? TextField(
                    controller: _controller.searchController,
                    onChanged: _controller.filterParties,
                    decoration: const InputDecoration(
                      hintText: 'Search Parties...',
                    ),
                    focusNode: _controller.searchFocusNode,
                    autofocus: true,
                  )
                : const Text("Parties");
          }),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Obx(() {
                return Icon(
                    _controller.isSearching.value ? Icons.close : Icons.search);
              }),
              onPressed: () {
                _controller.searchController.clear();
                _controller.filterParties('');
                _controller.toggleSearch();
                if (_controller.isSearching.value) {
                  _controller.searchFocusNode.requestFocus();
                } else {
                  _controller.searchFocusNode.unfocus();
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
              if (_controller.isLoading.value) {
                return const CircularProgressIndicator();
              } else if (_controller.filteredParties.isEmpty) {
                return const Text('No Parties');
              } else {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: _controller.fetchParties,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                          itemCount: _controller.filteredParties.length,
                          itemBuilder: (context, index) {
                            final party = _controller.filteredParties[index];
                            return ListTile(
                              onTap: () {
                                Get.to(UpdatePartyScreen(party: party));
                              },
                              leading:
                                  const CircleAvatar(child: Icon(Icons.person)),
                              title: Text(party.name),
                              subtitle: Text(party.phone),
                              trailing: Text(party.role),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const Divider(height: 0, thickness: 0)),
                    ),
                  ),
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
