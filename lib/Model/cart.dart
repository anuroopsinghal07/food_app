import 'package:food_app/Utility/constant.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String priceUnit;
  final String imageName;
  final String productId;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price,
      required this.priceUnit,
      required this.imageName,
      required this.productId});

  String get totalPriceString {
    final total = price * quantity;
    return total.toStringAsFixed(1);
  }
}

class Cart {
  const Cart({this.items = const <String, CartItem>{}});

  //Map<String, CartItem> _items = {};

  final Map<String, CartItem> items;

  // Map<String, CartItem> get items {
  //   return {..._items};
  // }

  int get itemCount {
    return items.length;
  }

  double get totalAmount {
    var total = 0.0;
    items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    if (total < 30) {
      total += deliveryCharge;
    }
    return total;
  }
}
