import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:food_app/Model/product.dart';

class ProductDataProvider {
  Future<List<Product>?> fetchProducts(bool isHitProductQuery) async {
    try {
      var jsonText = await rootBundle.loadString('assets/json/food_data.json');
      return _parseJsonText(jsonText, isHitProductQuery);
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<List<Product>?> _parseJsonText(
      String jsonText, bool isHitProductQuery) {
    try {
      List list = json.decode(jsonText);
      List<Product> productList = <Product>[];

      for (var element in list) {
        productList.add(Product.fromJson(element));
      }

      if (isHitProductQuery && productList.isNotEmpty) {
        productList = productList
            .where((product) => product.isHit != null ? product.isHit! : false)
            .toList();
      }

      return productList.isNotEmpty
          ? Future.value(productList)
          : Future.value(null);
    } catch (_) {
      throw Exception('failed to load products');
    }
  }
}
