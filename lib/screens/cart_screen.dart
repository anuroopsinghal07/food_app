import 'package:flutter/material.dart';
import 'package:food_app/Bloc/CartBloc/cart_bloc.dart';
import 'package:food_app/Bloc/CartBloc/cart_state.dart';
import 'package:food_app/Model/cart.dart';
import 'package:food_app/Utility/constant.dart';
import 'package:food_app/widgets/Counter/counter_widget.dart';
import 'package:food_app/widgets/bottom_price_bar.dart';
import 'package:food_app/widgets/cart_food_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/widgets/message.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, required this.cartBloc}) : super(key: key);
  final CartBloc cartBloc;

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: BlocProvider.value(
        value: widget.cartBloc,
        child: BlocBuilder(
            bloc: widget.cartBloc,
            builder: (context, state) {
              print('cart builder $state');
              if (state is CartFetchedState) {
                return CartView(
                  totalHeight: totalHeight,
                  cart: state.cart,
                );
              } else {
                return const Message(message: 'Cart is empty');
              }
            }),
      ),

      // BlocProvider(

      //   create: (BuildContext context) => widget.cartBloc,
      //   child: ,
      // ),
    );
  }
}

class CartView extends StatelessWidget {
  const CartView({Key? key, required this.totalHeight, required this.cart})
      : super(key: key);

  final double totalHeight;
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 10),
            height: totalHeight * .75,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text('We will deliver in 24 minutes to the address:',
                        style: Theme.of(context).textTheme.headline1),
                  ),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text('100a Ealing Rd',
                            style: Theme.of(context).textTheme.headline2),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text('Change address',
                              style: Theme.of(context).textTheme.bodyText1))
                    ],
                  ),
                  SizedBox(
                    //color: Colors.red,
                    height: (cart.items.length * 140) + 220,
                    child: ListView.builder(
                        itemCount: cart.items.length + 1,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          print('cart item list itemBuilder $index');
                          if (index == cart.items.length) {
                            return CutleryAndDeliveryChargeWidget(
                              addDeliveryCharge:
                                  cart.totalAmount >= 30 ? false : true,
                            );
                          }
                          //final cartItem = cart.items[index];

                          final cartItem = cart.items.values.toList()[index];
                          print(cartItem.quantity);
                          return CartFoodListItem(
                            key: Key(cartItem.id),
                            itemHeight: 140,
                            cartItem: cartItem,
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          //color: Colors.blueAccent,
          height: totalHeight * .17,
          child: CartPaymentWidget(
            widgetHeight: totalHeight * .17,
            cart: cart,
          ),
        ),
      ],
    );
  }
}

class CartPaymentWidget extends StatelessWidget {
  const CartPaymentWidget(
      {Key? key, required this.widgetHeight, required this.cart})
      : super(key: key);

  final double widgetHeight;
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    var paymentHeaderText = Text(
      'Payment Method',
      style: Theme.of(context).textTheme.bodyText1,
    );
    var paymentMethodText = Text(
      'Apple Pay',
      style: Theme.of(context).textTheme.headline2,
    );
    final orientation = MediaQuery.of(context).orientation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (orientation == Orientation.portrait)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            //color: Colors.red,
            height: widgetHeight * 0.2,
            child: paymentHeaderText,
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          //color: Colors.brown,
          height: widgetHeight * 0.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (orientation == Orientation.landscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    paymentHeaderText,
                    const Text(': '),
                    paymentMethodText
                  ],
                ),
              if (orientation == Orientation.portrait) paymentMethodText,
              const Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ],
          ),
        ),
        SizedBox(
          height: widgetHeight * 0.1,
        ),
        SizedBox(
          // color: Colors.green,
          height: orientation == Orientation.landscape
              ? widgetHeight * 0.6
              : widgetHeight * 0.4,
          child: Center(
            child: BottomPriceBar(
              barType: BottomPriceBarType.pay,
              cart: cart,
            ),
          ),
        )
      ],
    );
  }
}

class CutleryAndDeliveryChargeWidget extends StatelessWidget {
  const CutleryAndDeliveryChargeWidget(
      {Key? key, required this.addDeliveryCharge})
      : super(key: key);

  final bool addDeliveryCharge;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.dining,
                  ),
                  Text(
                    'Cutlery',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  CounterWidget(
                      currentValue: 1,
                      counterCallback: (value) {},
                      increaseCallback: () {},
                      decreaseCallback: () {},
                      minNumber: 1)
                ]),
          ),
          const Divider(),
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Free delivery from \$30',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                Text(
                  addDeliveryCharge ? '\$$deliveryCharge' : '\$0.0',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
