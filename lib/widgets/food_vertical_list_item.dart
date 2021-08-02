import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Bloc/CartBloc/cart_bloc.dart';
import 'package:food_app/Model/product.dart';
import 'package:food_app/screens/food_detail_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodVerticalListItem extends StatelessWidget {
  const FoodVerticalListItem({Key? key, required this.product})
      : super(key: key);

  final Product product;

  void _openFoodDetails(BuildContext context, Product product) {
    final cartBloc = BlocProvider.of<CartBloc>(context);

    showBarModalBottomSheet(
      expand: true,
      barrierColor: Colors.black.withAlpha(200),
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => FoodDetailScreen(
        product: product,
        cartBloc: cartBloc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final price = product.price != null ? '${product.price}' : "";
    final priceUnit = product.priceUnit ?? "";

    var kCal = "";
    final nutrition = product.nutrition == null
        ? null
        : product.nutrition!
            .firstWhere((nutrition) => nutrition.title == "kcal");

    if (nutrition != null) {
      kCal = nutrition.value ?? '';
      kCal += ' ';
      kCal += nutrition.title ?? '';
    }

    return InkWell(
      onTap: () {
        _openFoodDetails(context, product);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 120,
        width: double.infinity,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: Image.asset(
                'assets/images/${product.imageName}',
                width: 80,
                height: 80,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title ?? 'No Name',
                      style: Theme.of(context).textTheme.bodyText1),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          color: Colors.grey.shade200,
                          child: Text(
                            '$priceUnit$price',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            kCal,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
