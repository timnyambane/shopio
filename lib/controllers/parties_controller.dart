import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/constants.dart';

class PartiesController extends GetxController {
  final loading = true.obs;
  final parties = <Map<String, dynamic>>[].obs;
  final filteredParties = <Map<String, dynamic>>[].obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchParties();
  }

  Future<void> fetchParties() async {
    loading.value = true;
    try {
      final url = Uri.parse(Constants.partiesEndpoint);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        parties.assignAll(responseData.cast<Map<String, dynamic>>());
        filterParties('');
      } else {
        print('Failed to fetch parties. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching parties: $e');
    } finally {
      loading.value = false;
    }
  }

  void filterParties(String query) {
    if (query.isEmpty) {
      filteredParties.assignAll(parties);
    } else {
      filteredParties.assignAll(parties.where((party) {
        final name = party['name'] ?? '';
        final phone = party['phone'] ?? '';
        return name.toLowerCase().contains(query.toLowerCase()) ||
            phone.toLowerCase().contains(query.toLowerCase());
      }).toList());
    }
  }
}
