import 'package:food_app/Model/cart.dart';

const _delay = Duration(milliseconds: 800);

class CartRepository {
  Map<String, CartItem> _items = {};

  Future<Map<String, CartItem>> loadCartItems() =>
      Future.delayed(_delay, () => _items);

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, double price, String title, int quantity,
      String priceUnit, String imageName) {
    if (_items.containsKey(productId)) {
      //change quantity
      _items.update(
        productId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            quantity: existingCartItem.quantity + quantity,
            price: existingCartItem.price,
            priceUnit: existingCartItem.priceUnit,
            imageName: existingCartItem.imageName,
            productId: existingCartItem.productId),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            quantity: quantity,
            price: price,
            priceUnit: priceUnit,
            imageName: imageName,
            productId: productId),
      );
    }
  }

  void update(String productId, int quantity) {
    if (_items.containsKey(productId)) {
      //change quantity
      if (quantity > 0) {
        _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: quantity,
              price: existingCartItem.price,
              priceUnit: existingCartItem.priceUnit,
              imageName: existingCartItem.imageName,
              productId: existingCartItem.productId),
        );
      } else {
        removeItem(productId);
      }
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(productId, (existingItem) {
        final newItem = CartItem(
            id: existingItem.id,
            title: existingItem.title,
            price: existingItem.price,
            quantity: existingItem.quantity - 1,
            priceUnit: existingItem.priceUnit,
            imageName: existingItem.imageName,
            productId: existingItem.productId);
        return newItem;
      });
    } else {
      _items.remove(productId);
    }
  }

  void clear() {
    _items = {};
  }
}
