import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../model/product_model.dart';
import 'api_endpoint.dart';

class ProductApiService {
  static Future<List<ProductModel>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.37:3000/api/products'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<String> addProduct(ProductModel productModel) async {
    Uri uri = Uri.parse('http://192.168.1.37:3000/api/products');
    Map<String, dynamic> map = productModel.toJson();
    String mapStr = jsonEncode(map);
    Response response = await http.post(uri, body: mapStr, headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 201) {
      return 'Product added successfully';
    } else {
      throw 'Something went wrong';
    }
  }

  static Future<String> updateProduct(
      String productId, ProductModel productModel) async {
    Map<String, dynamic> map = productModel.toJson();
    String mapStr = jsonEncode(map);
    Uri uri = Uri.parse('${ApiEndpoints.product}/$productId');
    Response response = await http.put(uri, body: mapStr, headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      return 'Product updated successfully';
    } else {
      throw 'Something went wrong';
    }
  }

  static Future<ProductModel> deleteProduct(String id) async {
    String url = '${ApiEndpoints.product}/$id';
    Uri uri = Uri.parse(url);
    Response response = await http.delete(uri);
    String body = response.body;
    var json = jsonDecode(body);
    ProductModel productModel = ProductModel.fromJson(json);
    return productModel;
  }
}
