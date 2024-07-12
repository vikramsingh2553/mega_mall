import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../service/product_api_service.dart';
import 'add_product_screen.dart';
import 'detail_screen.dart';
import 'edit_product_scren.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductApiService productApiService = ProductApiService();
  List<ProductModel> products = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<ProductModel> fetchedProducts = await ProductApiService.fetchProducts();
      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching products: $e';
        isLoading = false;
      });
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
      await ProductApiService.deleteProduct(productId);
      await fetchProducts();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }


  Future<void> updateProduct(ProductModel product) async {
    try {
      await ProductApiService.updateProduct(product.id ,product);
      await fetchProducts();
    } catch (e) {
      print('Error editing product: $e');
      setState(() {
        errorMessage = 'Error editing product: $e';
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Center(
          child: Text(
            'Products',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : errorMessage.isNotEmpty
          ? Center(
        child: Text(errorMessage),
      )
          : products.isEmpty
          ? const Center(
        child: Text('No products available'),
      )
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          ProductModel product = products[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.white,
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(product: product),
                  ),
                );
              },
              title: Text(
                product.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                product.description,
                style: const TextStyle(color: Colors.black),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProductScreen(
                            product: product,
                            onEdit: (updatedProduct) {
                              updateProduct(updatedProduct);
                            },
                          ),
                        ),
                      );
                    },
                  ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Confirm Deletion'),
                    content: Text('Are you sure you want to delete ${product.name}?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Delete'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          deleteProduct(product.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),


                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(
                onAdd: (ProductModel product) {
                  addProduct(product);
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
