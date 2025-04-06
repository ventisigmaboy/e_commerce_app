import 'package:e_commerce_app/config/constants.dart';
import 'package:e_commerce_app/features/models/product_res_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductService {
  Future<List<ProductResModel>> fetchProducts() async {
    var url = Uri.http(kBaseUrl, kProductUrl);
    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        // Parse JSON and convert to List<ProductResModel>
        List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => ProductResModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: ${e.toString()}');
    }
  }
}