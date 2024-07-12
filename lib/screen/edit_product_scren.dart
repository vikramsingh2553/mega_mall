import 'package:flutter/material.dart';
import 'package:mega_mall/model/product_model.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel product;
  final Function(ProductModel) onEdit;

  const EditProductScreen({required this.product, required this.onEdit});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.name);
    descriptionController = TextEditingController(text: widget.product.description);
    priceController = TextEditingController(text: widget.product.price.toString());
  }

  void editProduct() {
    final String name = nameController.text.trim();
    final String description = descriptionController.text.trim();
    final double? price = double.tryParse(priceController.text.trim());

    if (name.isNotEmpty && description.isNotEmpty && price != null && price >= 0) {
      final updatedProduct = ProductModel(
        id: widget.product.id,
        name: name,
        description: description,
        price: price,
      );
      widget.onEdit(updatedProduct);
      Navigator.pop(context);
    } else {
      String errorMessage = 'Please enter all required fields';
      if (price != null && price < 0) {
        errorMessage = 'Price must be a non-negative number';
      } else if (name.isEmpty || description.isEmpty) {
        errorMessage = 'Please fill in all fields';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Edit Product'),
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
              onPressed: editProduct,
              child: const Text('Edit Product'),
            ),
          ],
        ),
      ),
    );
  }
}
