import 'package:food_app/DataProvider/product_data_provider.dart';
import 'package:food_app/Model/product.dart';

class ProductRepository {
  final ProductDataProvider _productDataProvider = ProductDataProvider();

  Future<List<Product>?> fetchProducts(bool isHitProductQuery) =>
      _productDataProvider.fetchProducts(isHitProductQuery);
}
