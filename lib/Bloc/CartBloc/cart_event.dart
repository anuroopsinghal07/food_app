import 'package:food_app/Model/cart.dart';
import 'package:food_app/Model/product.dart';

abstract class CartEvent {}

class CartFetchEvent extends CartEvent {}

class CartItemAddEvent extends CartEvent {
  CartItemAddEvent({required this.product, required this.quantity});
  final Product product;
  final int quantity;
}

class CartItemRemoveEvent extends CartEvent {
  CartItemRemoveEvent(this.item);
  final CartItem item;
}

class CartItemUpdateQuantityEvent extends CartEvent {
  CartItemUpdateQuantityEvent(
      {required this.productId, required this.quantity});
  final String productId;
  final int quantity;
}

class CartItemRemoveAllEvent extends CartEvent {}
