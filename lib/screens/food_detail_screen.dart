import 'package:flutter/material.dart';
import 'package:food_app/Bloc/CartBloc/cart_bloc.dart';
import 'package:food_app/Bloc/CartBloc/cart_event.dart';
import 'package:food_app/Model/product.dart';
import 'package:food_app/widgets/Counter/counter_widget.dart';
import 'package:food_app/widgets/food_details/nutrient_widget.dart';

// class Nutri {
//   final String value;
//   final String label;

//   Nutri({required this.value, required this.label});
// }

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen(
      {Key? key, required this.product, required this.cartBloc})
      : super(key: key);

  final Product product;
  final CartBloc cartBloc;

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  var _quantity = 1;

  String get _totalPriceString {
    var total = 0.0;

    if (widget.product.price != null) {
      total = widget.product.price! * _quantity;
      return total.toStringAsFixed(1);
    }
    return '$total';
  }

  @override
  Widget build(BuildContext context) {
    var totalHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: totalHeight * 0.35,
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: Image.asset(
                    'assets/images/${widget.product.imageName}',
                  ),
                ),
              ),
              SizedBox(
                //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                //height: totalHeight * 0.20,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.product.title ?? "Name missing",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.product.description ?? 'Description missing',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.product.nutrition != null)
                _buildNutrientWidget(totalHeight),
              _buildAddInProductWidget(totalHeight, context),
              _buildAddToCartButtonWidget(totalHeight, context),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  ConstrainedBox _buildAddToCartButtonWidget(
      double totalHeight, BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: totalHeight * 0.10,
      ),
      //height: totalHeight * 0.07,
      //color: Colors.yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CounterWidget(
              currentValue: _quantity,
              counterCallback: (value) {
                setState(() {
                  _quantity = value;
                });
              },
              increaseCallback: () {},
              decreaseCallback: () {},
              minNumber: 1),
          GestureDetector(
            onTap: () {
              Future.delayed(const Duration(seconds: 1)).then(
                (value) => widget.cartBloc.add(
                  CartItemAddEvent(
                      product: widget.product, quantity: _quantity),
                ),
              );

              Navigator.of(context).pop();
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color: Colors.black,
                child: Text(
                  'Add to cart \$$_totalPriceString',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildAddInProductWidget(double totalHeight, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: totalHeight * 0.015, left: 10, right: 10),
      height: totalHeight * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Add in ${widget.product.title ?? ''}',
              style: Theme.of(context).textTheme.bodyText1),
          const Icon(
            Icons.arrow_forward_ios,
            size: 15,
          ),
        ],
      ),
    );
  }

  Container _buildNutrientWidget(double totalHeight) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      height: totalHeight * 0.15,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.product.nutrition!.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: NutrientWidget(nutri: data),
          );
        }).toList(),
      ),
    );
  }
}
