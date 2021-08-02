import 'package:food_app/Bloc/CartBloc/cart_event.dart';
import 'package:food_app/Bloc/CartBloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Model/cart.dart';
import 'package:food_app/Repository/cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository = CartRepository();

  CartBloc(CartState initialState) : super(initialState);
  @override
  void onTransition(Transition<CartEvent, CartState> transition) {
    print('onTransition');
    super.onTransition(transition);
  }

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    print('mapEventToState');
    if (event is CartFetchEvent) {
      yield* _mapCartFetchEventToState();
    } else if (event is CartItemAddEvent) {
      yield* _mapCartItemAddEventToState(event, state);
    } else if (event is CartItemRemoveEvent) {
      yield* _mapCartItemRemoveEventToState(event, state);
    } else if (event is CartItemUpdateQuantityEvent) {
      yield* _mapCartUpdateQuantiryEventToState(event, state);
    } else if (event is CartItemRemoveAllEvent) {
      yield* _mapCartRemoveAllEventToState(state);
    }
  }

  Stream<CartState> _mapCartFetchEventToState() async* {
    yield CartFetchingState();

    try {
      final items = await cartRepository.loadCartItems();
      if (items.isEmpty) {
        yield CartEmptyState();
      } else {
        yield CartFetchedState(cart: Cart(items: {...items}));
      }
    } catch (_) {
      yield CartErrorState();
    }
  }

  Stream<CartState> _mapCartItemAddEventToState(
      CartItemAddEvent event, CartState state) async* {
    print('_mapCartItemAddEventToState');
    if (state is CartFetchedState || state is CartEmptyState) {
      try {
        cartRepository.addItem(
            event.product.id.toString(),
            event.product.price ?? 0.0,
            event.product.title ?? '',
            event.quantity,
            event.product.priceUnit ?? '\$',
            event.product.imageName ?? '');

        //Map<String, CartItem> items = {...state.cart.items};

        yield CartFetchedState(cart: Cart(items: cartRepository.items));
      } on Exception {
        yield CartErrorState();
      }
    }
  }

  Stream<CartState> _mapCartItemRemoveEventToState(
      CartItemRemoveEvent event, CartState state) async* {
    if (state is CartFetchedState) {
      try {
        cartRepository.removeSingleItem(event.item.productId);

        //Map<String, CartItem> items = {...state.cart.items};

        if (cartRepository.items.isEmpty) {
          yield CartEmptyState();
        } else {
          yield CartFetchedState(cart: Cart(items: cartRepository.items));
        }
      } on Exception {
        yield CartErrorState();
      }
    }
  }

  Stream<CartState> _mapCartUpdateQuantiryEventToState(
      CartItemUpdateQuantityEvent event, CartState state) async* {
    if (state is CartFetchedState) {
      try {
        cartRepository.update(event.productId, event.quantity);

        if (cartRepository.items.isEmpty) {
          yield CartEmptyState();
        } else {
          yield CartFetchedState(cart: Cart(items: cartRepository.items));
        }
      } on Exception {
        yield CartErrorState();
      }
    }
  }

  Stream<CartState> _mapCartRemoveAllEventToState(CartState state) async* {
    if (state is CartFetchedState) {
      try {
        cartRepository.clear();

        if (cartRepository.items.isEmpty) {
          yield CartEmptyState();
        } else {
          yield CartFetchedState(cart: Cart(items: cartRepository.items));
        }
      } on Exception {
        yield CartErrorState();
      }
    }
  }
}
