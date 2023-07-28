import 'package:flutter/foundation.dart';
import 'package:product_cart/product/model/product_model.dart';
import 'package:product_cart/product/service/product_api_service.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider(this.productApiService);

  ProductApiService productApiService;

  List<ProductModel> productList = [];

  bool isError = false;
  bool isLoading = false;

  Future fetchProductList() async {
    try {
      isLoading = true;
      notifyListeners();
      productList = await productApiService.fetchProductList();
      notifyListeners();
    } catch (e) {
      isError = true;
    }
    isLoading = false;
    notifyListeners();
  }

  Future addProduct(ProductModel product) async {
    try {
      bool isSuccess = await productApiService.addProduct(product);
      print('Product added $isSuccess');
    } catch (e) {
      print('Error $e');
    }
  }
}
