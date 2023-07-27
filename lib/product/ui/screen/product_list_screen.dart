import 'package:flutter/material.dart';
import 'package:product_cart/product/provider/product_provider.dart';
import 'package:product_cart/product/ui/widget/product_row_widget.dart';
import 'package:product_cart/shared/strings_const.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.isError) {
            return errorWidget(provider);
          }

          if (provider.productList.isEmpty) {
            return const Center(child: Text(emptyListMsg));
          }

          return Padding(
            padding: const EdgeInsets.all(8),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: provider.productList.length,
              itemBuilder: (context, index) {
                return ProductRowWidget(
                  productModel: provider.productList[index],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Center errorWidget(ProductProvider provider) {
    return Center(
        child: Column(
      children: [
        const Text(apiErrorMsg),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            provider.fetchProductList();
          },
          child: const Text(retry),
        )
      ],
    ));
  }
}
