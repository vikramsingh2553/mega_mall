import 'package:flutter/material.dart';
import 'package:mega_mall/service/product_api_service.dart';

import '../model/product_model.dart';


class ProductProvider extends ChangeNotifier {
  final ProductApiService apiService = ProductApiService();
  List<ProductApiService> products = [];

  Future<void> fetchProducts() async {
    try {
      List<ProductApiService> fetchedProducts = (await ProductApiService.fetchProducts()).cast<ProductApiService>();
      products = fetchedProducts;
      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await ProductApiService.addProduct(product);
      await fetchProducts();
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await ProductApiService.deleteProduct(productId );
      await fetchProducts();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

}