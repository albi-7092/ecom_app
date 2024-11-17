import 'dart:convert'; // For encoding and decoding JSON
import 'dart:developer';

import 'package:http/http.dart' as http;

Future<bool> updateData(String id, Map<String, dynamic> updatedData) async {
  final String apiUrl =
      'https://dummyjson.com/products/$id'; // Replace with your API URL

  try {
    log("product id:$id");
    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer your_api_token',
      },
      body: jsonEncode(updatedData),
    );

    if (response.statusCode == 200) {
      log('Update successful');
      return true;
    } else {
      log('Failed to update: ${response.statusCode}');
      log('Error: ${response.body}');
      return false;
    }
  } catch (error) {
    log('Error during update: $error');
    return false;
  }
}
