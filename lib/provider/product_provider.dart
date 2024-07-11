import 'package:flutter/material.dart';
import 'package:mega_mall/service/api_service.dart';

import '../model/product_model.dart';


class ProductProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  List<ProductModel> products = [];

  Future<void> fetchProducts() async {
    try {
      List<ProductModel> fetchedProducts = await ApiService.fetchProducts();
      products = fetchedProducts;
      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await ApiService.addProduct(product);
      await fetchProducts();
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await ApiService.deleteProduct(id);
      await fetchProducts();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

}