import 'package:flutter/material.dart';
import 'package:mega_mall/model/product_model.dart';
import 'package:mega_mall/service/product_api_service.dart';

class AddProductScreen extends StatefulWidget {
  final Function(ProductModel) onAdd;

  const AddProductScreen({required this.onAdd});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';

  void addProduct() async {
    final String name = nameController.text;
    final String description = descriptionController.text;
    final double? price = double.tryParse(priceController.text);

    if (name.isNotEmpty && description.isNotEmpty && price != null) {
      final newProduct = ProductModel(
        id: '',
        name: name,
        description: description,
        price: price,
      );

      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      try {
        print('Sending request to add product: $newProduct');
        await ProductApiService.addProduct(newProduct);
        print('Product added successfully');
        widget.onAdd(newProduct);
        Navigator.pop(context);
      } catch (e) {
        print('Error occurred while adding product: $e');
        setState(() {
          errorMessage = 'Failed to add product: $e';
          isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Product Description'),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Product Price'),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: addProduct,
              child: const Text('Add Product'),
            ),
            if (errorMessage.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
