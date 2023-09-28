import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/parties_controller.dart';
import 'add_party.dart';

class PartiesScreen extends StatefulWidget {
  const PartiesScreen({super.key});

  @override
  PartiesScreenState createState() => PartiesScreenState();
}

class PartiesScreenState extends State<PartiesScreen> {
  final _controller = Get.put(PartiesController());
  bool isSearching = false;
  final _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: isSearching
              ? TextField(
                  controller: _controller.searchController,
                  onChanged: _controller.filterParties,
                  decoration: const InputDecoration(
                    hintText: 'Search Parties...',
                  ),
                  focusNode: _searchFocusNode,
                )
              : const Text("Parties"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(isSearching ? Icons.close : Icons.search),
              onPressed: () {
                _controller.searchController.clear();
                _controller.filterParties('');
                setState(() {
                  isSearching = !isSearching;
                  if (isSearching) {
                    _searchFocusNode.requestFocus();
                  } else {
                    _searchFocusNode.unfocus();
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.person_add_alt_1,
                //color: Theme.of(context).primaryColor),
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
              if (_controller.loading.value) {
                return const CircularProgressIndicator();
              } else if (_controller.filteredParties.isEmpty) {
                return const Text('No Parties');
              } else {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: _controller.fetchParties,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: _controller.filteredParties.length,
                        itemBuilder: (context, index) {
                          final party = _controller.filteredParties[index];
                          return Card(
                            child: ListTile(
                              leading:
                                  const CircleAvatar(child: Icon(Icons.person)),
                              title: Text(party['name']),
                              subtitle: Text(party['phone']),
                              trailing: Text(party['role']),
                            ),
                          );
                        },
                        // separatorBuilder: (context, index) =>
                        //     const Divider(height: 0, thickness: 0),
                      ),
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
