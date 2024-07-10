import 'package:flutter/material.dart';
import 'package:mega_mall/service/api_service.dart';


import '../model/product_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      List<ProductModel> fetchedProducts = await ApiService.fetchProducts();
      setState(() {
        products = fetchedProducts;
      });
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

  Future<void> deleteProduct(String productId) async {
    try {
      await ApiService.deleteProduct(productId);
      await fetchProducts();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          ProductModel product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text(product.description),

          );
        },
      ),
    );
  }
}