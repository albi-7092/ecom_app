import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

Future<dynamic> fetchData() async {
  final url = Uri.parse('https://dummyjson.com/products');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var dt = data['products'] as List;
      log("products:${dt.length}");

      return data;
    } else {
      log('Failed to load data. Status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    log('Error occurred: $e');
    return null;
  }
}
