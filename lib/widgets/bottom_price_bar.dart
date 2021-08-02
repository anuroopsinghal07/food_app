import 'package:flutter/material.dart';
import 'package:food_app/Bloc/CartBloc/cart_bloc.dart';
import 'package:food_app/Bloc/CartBloc/cart_event.dart';
import 'package:food_app/Model/cart.dart';
import 'package:food_app/screens/cart_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum BottomPriceBarType { pay, cart }

class BottomPriceBar extends StatefulWidget {
  const BottomPriceBar({Key? key, required this.barType, required this.cart})
      : super(key: key);

  final BottomPriceBarType barType;
  final Cart cart;

  @override
  _BottomPriceBarState createState() => _BottomPriceBarState();
}

class _BottomPriceBarState extends State<BottomPriceBar> {
  var priceUnit = '\$';

  @override
  Widget build(BuildContext context) {
    if (widget.cart.items[0] != null) {
      priceUnit = widget.cart.items[0]!.priceUnit;
    }

    return GestureDetector(
      onTap: () {
        _performNavigation(context);
      },
      child: _buildBottomPricebar(context),
    );
  }

  void _openCart(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);

    showBarModalBottomSheet(
      expand: true,
      barrierColor: Colors.black.withAlpha(200),
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => CartScreen(
        cartBloc: cartBloc,
      ),
    );
  }

  _performNavigation(BuildContext context) {
    if (widget.barType == BottomPriceBarType.cart) {
      _openCart(context);
    } else {
      BlocProvider.of<CartBloc>(context).add(CartItemRemoveAllEvent());
      Navigator.of(context).pop();
    }
  }

  ClipRRect _buildBottomPricebar(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: Colors.black,
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.barType == BottomPriceBarType.cart ? 'Cart' : 'Pay',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
              ),
            ),
            Text(
              '24 mins ',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white, fontSize: 12),
            ),
            Text(
              '· $priceUnit${widget.cart.totalAmount.toStringAsFixed(1)}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
