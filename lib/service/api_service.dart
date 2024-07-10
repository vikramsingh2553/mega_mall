import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../model/product_model.dart';
import 'api_endpoint.dart';

class ApiService {
  static Future<ProductModel> fetchProduct(String productId) async {
    String url = '${ApiEndpoints.product}/$productId';
    Uri uri = Uri.parse(url);
    Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String body = response.body;
      var json = jsonDecode(body);
      ProductModel productModel = ProductModel.fromJson(json);
      return productModel;
    } else {
      throw 'Something went wrong';
    }
  }

  static Future<List<ProductModel>> fetchProducts() async {
    Uri uri = Uri.parse(ApiEndpoints.product);
    Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String body = response.body;
      List<Map<String, dynamic>> listMap = jsonDecode(body);
      List<ProductModel> productList = [];
      for (int i = 0; i < listMap.length; i++) {
        ProductModel productModel = ProductModel.fromJson(listMap[i]);
        productList.add(productModel);
      }

      return productList;
    } else {
      throw 'Something went wrong';
    }
  }

  static Future<String> addProduct(ProductModel productModel) async {
    Uri uri = Uri.parse(ApiEndpoints.product);
    Map<String, dynamic> map = productModel.toJson();
    String mapStr = jsonEncode(map);
    Response response = await http.post(uri, body: mapStr);
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
    Response response = await http.put(uri, body: mapStr);
    if (response.statusCode == 200) {
      return 'Product updated successfully';
    } else {
      throw 'Something went wrong';
    }
  }

  static Future<ProductModel> deleteProduct(String productId) async {
    String url = '${ApiEndpoints.product}/$productId';
    Uri uri = Uri.parse(url);
    Response response = await http.delete(uri);
    String body = response.body;
    var json = jsonDecode(body);
    ProductModel productModel =
    ProductModel.fromJson(json);
    return productModel;
  }
}