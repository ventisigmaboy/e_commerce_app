import 'package:e_commerce_app/config/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductService {
  Future<List<dynamic>> fetchProducts() async {
    var url = Uri.http(kBaseUrl, kProductUrl);
    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: ${e.toString()}');
    }
  }
}