import 'package:flutter/material.dart';
import 'package:food_app/Bloc/CartBloc/cart_bloc.dart';
import 'package:food_app/Model/product.dart';
import 'package:food_app/screens/food_detail_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodHorizontalListItem extends StatelessWidget {
  const FoodHorizontalListItem(
      {Key? key,
      required this.colors,
      required int colorIndex,
      required double bottomHeightOfBox,
      required double itemWidth,
      required double foodImageHeight,
      required this.product})
      : _colorIndex = colorIndex,
        _bottomHeightOfBox = bottomHeightOfBox,
        _itemWidth = itemWidth,
        _foodImageHeight = foodImageHeight,
        super(key: key);

  final List<Color> colors;
  final int _colorIndex;
  final double _bottomHeightOfBox;
  final double _itemWidth;
  final double _foodImageHeight;
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

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: Container(
                //color: Colors.blue.shade300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      colors[_colorIndex],
                      colors[_colorIndex],
                      colors[_colorIndex],
                      Colors.purple.shade100
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: _bottomHeightOfBox,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Text(
                              product.title ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              color: Colors.black,
                              child: Text(
                                '$priceUnit$price',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                          // TextButton(
                          //   onPressed: () {},
                          //   child: Text(
                          //     '\$120.8',
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .headline2!
                          //         .copyWith(color: Colors.white),
                          //   ),
                          //   style: ElevatedButton.styleFrom(
                          //     primary: Colors.grey.shade900,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius:
                          //           BorderRadius.circular(15), // <-- Radius
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: (_itemWidth / 2) - (_foodImageHeight / 2),
            child: InkWell(
              onTap: () {
                _openFoodDetails(context, product);
              },
              child: Image.asset(
                'assets/images/${product.imageName}',
                width: _foodImageHeight,
                height: _foodImageHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
