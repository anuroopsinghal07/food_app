import 'package:flutter/material.dart';
import 'package:food_app/Bloc/CartBloc/cart_bloc.dart';
import 'package:food_app/Bloc/CartBloc/cart_event.dart';
import 'package:food_app/Model/cart.dart';
import 'package:food_app/widgets/Counter/counter_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartFoodListItem extends StatefulWidget {
  final double itemHeight;
  const CartFoodListItem(
      {Key? key, required this.itemHeight, required this.cartItem})
      : super(key: key);
  final CartItem cartItem;
  @override
  State<CartFoodListItem> createState() => _CartFoodListItemState();
}

class _CartFoodListItemState extends State<CartFoodListItem> {
  var _currentCount = 1;

  @override
  void initState() {
    super.initState();

    _currentCount = widget.cartItem.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // margin: const EdgeInsets.all(5),
      height: widget.itemHeight,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(
                  'assets/images/${widget.cartItem.imageName}',
                  width: 80,
                  height: 80,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(widget.cartItem.title,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            '${widget.cartItem.priceUnit}${widget.cartItem.totalPriceString}',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CounterWidget(
                        currentValue: _currentCount,
                        counterCallback: (value) {
                          _currentCount = value;
                        },
                        increaseCallback: () {
                          BlocProvider.of<CartBloc>(context).add(
                              CartItemUpdateQuantityEvent(
                                  productId: widget.cartItem.productId,
                                  quantity: _currentCount));
                        },
                        decreaseCallback: () {
                          BlocProvider.of<CartBloc>(context)
                              .add(CartItemRemoveEvent(widget.cartItem));
                        },
                        minNumber: 0),
                  ],
                ),
              )
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
