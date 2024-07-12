import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../model/product_model.dart';
import 'api_endpoint.dart';

class ProductApiService {
  static Future<List<ProductModel>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('${ApiEndpoints.product}'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<String> addProduct(ProductModel productModel) async {
    Uri uri = Uri.parse('${ApiEndpoints.product}s');
    Map<String, dynamic> map = productModel.toJson();
    String mapStr = jsonEncode(map);
    final response = await http.post(uri, body: mapStr, headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 201) {
      return 'Product added successfully';
    } else {
      throw 'Something went wrong';
    }
  }

  static Future<String> updateProduct(String productId, ProductModel productModel) async {
    try {
      Map<String, dynamic> map = productModel.toJson();
      String mapStr = jsonEncode(map);
      Uri uri = Uri.parse('${ApiEndpoints.product}/$productId');
      Response response = await http.put(uri, body: mapStr, headers: {
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        return 'Product updated successfully';
      } else {
        throw 'Failed to update product';
      }
    } catch (e) {
      throw 'Error updating product: $e';
    }
  }


  static Future<void> deleteProduct(String productId) async {
    if (productId == null) {
      throw 'Product ID cannot be null';
    }

    Uri uri = Uri.parse('${ApiEndpoints.product}/$productId');
    Response response = await http.delete(uri);

    if (response.statusCode == 200) {
      print('Product deleted successfully');
    } else {
      throw 'Failed to delete product: ${response.statusCode}';
    }
  }
  }
