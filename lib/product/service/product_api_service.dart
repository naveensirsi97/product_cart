import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:product_cart/product/model/product_model.dart';
import 'package:product_cart/shared/api_endpoints.dart';
import 'package:product_cart/shared/strings_const.dart';

class ProductApiService {
  Future<List<ProductModel>> fetchProductList() async {
    String url = ApiEndpoints.productUrl();
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      List<ProductModel> productList = [];
      for (var element in data) {
        ProductModel productModel = ProductModel.fromJson(element);
        productList.add(productModel);
      }

      return productList;
    }

    throw somethingWrong;
  }

  Future<bool> addProduct(ProductModel product) async {
    String url = ApiEndpoints.productUrl();
    Uri uri = Uri.parse(url);
    http.Response response = await http.post(
      uri,
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    }

    throw somethingWrong;
  }
}
