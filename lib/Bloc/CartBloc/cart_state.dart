import 'package:food_app/Model/cart.dart';

abstract class CartState {}

class CartUninitializedState extends CartState {}

class CartFetchingState extends CartState {}

class CartFetchedState extends CartState {
  final Cart cart;
  CartFetchedState({required this.cart});
}

class CartErrorState extends CartState {}

class CartEmptyState extends CartState {}
