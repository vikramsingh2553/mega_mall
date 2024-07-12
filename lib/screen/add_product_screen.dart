import 'package:flutter/material.dart';
import 'package:mega_mall/model/product_model.dart';

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

  void addProduct() {
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
      widget.onAdd(newProduct);
      Navigator.pop(context);
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
            ElevatedButton(
              onPressed: addProduct,
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
