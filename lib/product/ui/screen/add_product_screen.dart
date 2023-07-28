import 'package:flutter/material.dart';
import 'package:product_cart/product/model/product_model.dart';
import 'package:product_cart/product/model/rating_model.dart';
import 'package:product_cart/product/provider/product_provider.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _categoryController;
  late TextEditingController _imageController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _priceController = TextEditingController();
    _descriptionController = TextEditingController();
    _categoryController = TextEditingController();
    _imageController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _addProduct(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    // Parse the price as a double, or set it to 0.0 if invalid.
    double price = double.tryParse(_priceController.text) ?? 0.0;

    ProductModel newProduct = ProductModel(
      id: DateTime.now()
          .millisecondsSinceEpoch, // Generate a unique ID for the product.
      title: _titleController.text,
      price: price,
      description: _descriptionController.text,
      category: _categoryController.text,
      image: _imageController.text,
      rating: Rating(rate: 0.0, count: 0),
    );

    productProvider.addProduct(newProduct);

    _titleController.clear();
    _priceController.clear();
    _descriptionController.clear();
    _categoryController.clear();
    _imageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              TextField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _addProduct(context),
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
