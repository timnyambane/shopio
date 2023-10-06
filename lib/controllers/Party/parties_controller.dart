import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/party.dart';
import '../../utils/constants.dart';

class PartiesController extends GetxController {
  final isLoading = true.obs;
  final parties = <PartyModel>[].obs;
  final filteredParties = <PartyModel>[].obs;
  final searchController = TextEditingController();
  final isSearching = false.obs;
  final FocusNode searchFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    fetchParties();
  }

  Future<void> fetchParties() async {
    isLoading.value = true;
    try {
      final url = Uri.parse(Constants.partiesEndpoint);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<PartyModel> partyList = responseData
            .map((data) => PartyModel.fromMap(data as Map<String, dynamic>))
            .toList();

        parties.assignAll(partyList.toList());
        filterParties('');
      } else {
        Fluttertoast.showToast(
            msg: 'Failed to fetch parties. Status code: ${response.statusCode}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error fetching parties: $e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  void filterParties(String query) {
    if (query.isEmpty) {
      filteredParties.assignAll(parties);
    } else {
      filteredParties.assignAll(parties.where((party) {
        final name = party.name.toLowerCase();
        final phone = party.phone.toLowerCase();
        return name.contains(query.toLowerCase()) ||
            phone.contains(query.toLowerCase());
      }));
    }
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
  }
}
