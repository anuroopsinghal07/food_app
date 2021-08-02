import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/Bloc/ProductBloc/hit_products_bloc.dart';
import 'package:food_app/Bloc/ProductBloc/product_event.dart';
import 'package:food_app/Bloc/ProductBloc/product_state.dart';
import 'package:food_app/Model/product.dart';
import 'package:food_app/widgets/food_horizontal_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/widgets/message.dart';

class HorizontalFoodList extends StatefulWidget {
  const HorizontalFoodList({Key? key}) : super(key: key);

  @override
  State<HorizontalFoodList> createState() => _HorizontalFoodListState();
}

class _HorizontalFoodListState extends State<HorizontalFoodList> {
  int _current = 0;

  late List<Widget> _imageSliders;

  static List<Color> colors = <Color>[Colors.blue.shade300, Colors.cyanAccent];

  @override
  void initState() {
    super.initState();

    BlocProvider.of<HitProductsBloc>(context).add(HitProductsFetchEvent());
  }

  void _createSliderData(double carouselHeight, List<Product> products) {
    var _itemWidth = MediaQuery.of(context).size.width - 20;
    var _foodImageHeight = carouselHeight * 0.65;
    var _bottomHeightOfBox = carouselHeight - 20 - _foodImageHeight;
    _imageSliders = products.map((product) {
      var _index = products.indexOf(product);
      var _colorIndex = 0;
      if (_index % 2 == 0) {
        _colorIndex = 0;
      } else {
        _colorIndex = 1;
      }

      //var randomInt = Random().nextInt(Colors.primaries.length);
      return FoodHorizontalListItem(
        colors: colors,
        colorIndex: _colorIndex,
        bottomHeightOfBox: _bottomHeightOfBox,
        itemWidth: _itemWidth,
        foodImageHeight: _foodImageHeight,
        product: product,
      );
    }).toList();

    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var carouselHeight = MediaQuery.of(context).size.height * 0.4;
    //
    return BlocBuilder(
      bloc: BlocProvider.of<HitProductsBloc>(context),
      builder: (context, state) {
        if (state is ProductsUninitializedState) {
          return const Message(message: "Wait...");
        } else if (state is ProductsEmptyState) {
          return const Message(message: "No data found");
        } else if (state is ProductsErrorState) {
          return const Message(message: "Something went wrong");
        } else if (state is ProductsFetchingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final productsFetchedState = state as ProductsFetchedState;
          final products = productsFetchedState.products;
          print("products ${products.length}");
          return _buildCarousel(context, carouselHeight, products);
        }
      },
    );
  }

  Column _buildCarousel(
      BuildContext context, double carouselHeight, List<Product> products) {
    _createSliderData(carouselHeight, products);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Text(
            'Hits of the week',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        CarouselSlider(
          items: _imageSliders,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: false,
              //aspectRatio: 1.6,
              height: carouselHeight,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: products.map((product) {
              int index = products.indexOf(product);
              return Expanded(
                child: Container(
                  width: (MediaQuery.of(context).size.width - 20) /
                      _imageSliders.length,
                  height: 3.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: _current == index
                          ? Colors.grey.shade900
                          : Colors.grey.shade300,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                        ),
                      ]),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
