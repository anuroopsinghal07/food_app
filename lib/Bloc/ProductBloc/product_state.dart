import 'package:food_app/Model/product.dart';

abstract class ProductState {}

class ProductsUninitializedState extends ProductState {}

class ProductsFetchingState extends ProductState {}

class ProductsFetchedState extends ProductState {
  final List<Product> products;
  ProductsFetchedState({required this.products});
}

class ProductsErrorState extends ProductState {}

class ProductsEmptyState extends ProductState {}
