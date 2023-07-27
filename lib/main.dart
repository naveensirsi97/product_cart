import 'package:flutter/material.dart';
import 'package:product_cart/product/provider/product_provider.dart';
import 'package:product_cart/product/service/product_api_service.dart';
import 'package:product_cart/product/ui/screen/product_list_screen.dart';
import 'package:product_cart/shared/colors_const.dart';
import 'package:product_cart/shared/strings_const.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(const ProductKartApp());
}

class ProductKartApp extends StatelessWidget {
  const ProductKartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: initProviders(),
        child: const ProductListScreen(),
      ),
    );
  }

  List<SingleChildWidget> initProviders() {
    ProductApiService productApiService = ProductApiService();
    return [
      ChangeNotifierProvider<ProductProvider>(
        create: (_) => ProductProvider(
          productApiService,
        )..fetchProductList(),
      ),
    ];
  }
}
