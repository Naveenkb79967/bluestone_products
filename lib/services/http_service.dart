import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "https://fakestoreapi.com";

  // Fetch paginated product list
  Future<List<dynamic>> fetchProductList({required int limit, required int page}) async {
    final url = Uri.parse("$_baseUrl/products?limit=$limit&page=$page");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product list');
    }
  }

  // Fetch single product detail
  Future<Map<String, dynamic>> fetchProductDetail(int productId) async {
    final url = Uri.parse("$_baseUrl/products/$productId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product details');
    }
  }
}
