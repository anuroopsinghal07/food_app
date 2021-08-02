import 'package:flutter/material.dart';
import 'package:food_app/Bloc/CartBloc/cart_bloc.dart';
import 'package:food_app/Bloc/CartBloc/cart_event.dart';
import 'package:food_app/Bloc/CartBloc/cart_state.dart';
import 'package:food_app/Bloc/ProductBloc/hit_products_bloc.dart';
import 'package:food_app/Bloc/ProductBloc/product_event.dart';
import 'package:food_app/Bloc/ProductBloc/product_state.dart';
import 'package:food_app/Bloc/ProductBloc/products_bloc.dart';
import 'package:food_app/Model/cart.dart';
import 'package:food_app/Model/product.dart';
import 'package:food_app/widgets/bottom_price_bar.dart';
import 'package:food_app/widgets/message.dart';
import 'package:food_app/widgets/horizontal_food_list.dart';
import 'package:food_app/widgets/food_vertical_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/widgets/product_category_scroller.dart';

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({Key? key}) : super(key: key);

  @override
  _ProductListWidgetState createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductsBloc>(context).add(ProductsFetchEvent());
    BlocProvider.of<CartBloc>(context).add(CartFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<ProductsBloc>(context),
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
          return ProductListView(products: products);
        }
      },
    );
  }
}

class ProductListView extends StatefulWidget {
  const ProductListView({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<CartBloc>(context),
        builder: (context, state) {
          if (state is CartFetchedState) {
            return _buildListView(state.cart);
          } else {
            return _buildListView(null);
          }
        });
  }

  Stack _buildListView(Cart? cart) {
    print("_buildListView");
    return Stack(
      children: [
        LoadProductsView(
          products: widget.products,
          cart: cart,
        ),
        if (cart != null)
          LoadCartPriceBar(
            cart: cart,
          )
      ],
    );
  }
}

class LoadCartPriceBar extends StatefulWidget {
  const LoadCartPriceBar({Key? key, required this.cart}) : super(key: key);
  final Cart cart;

  @override
  State<LoadCartPriceBar> createState() => _LoadCartPriceBarState();
}

class _LoadCartPriceBarState extends State<LoadCartPriceBar> {
  bool selected = false;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  startAnimation() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      selected = true;
    });
  }
  // @override
  // void didUpdateWidget(covariant LoadCartPriceBar oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   _alignment = const AlignmentDirectional(0.0, 0.7);
  //   startAnimation();
  // }

  // @override
  // void didUpdateWidget(covariant ProductListView oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   _alignment = const AlignmentDirectional(0.0, 0.7);
  //   startAnimation();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedAlign(
          alignment: selected ? Alignment.center : Alignment.bottomCenter,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: AnimatedOpacity(
            opacity: selected ? 1 : 0,
            duration: const Duration(seconds: 1),
            child: Padding(
              padding: EdgeInsets.only(bottom: selected ? 10 : 0),
              child: BottomPriceBar(
                barType: BottomPriceBarType.cart,
                cart: widget.cart,
              ),
            ),
          ),
        )

        // AnimatedContainer(
        //   duration: const Duration(seconds: 5),
        //   alignment: _alignment,
        //   curve: Curves.fastOutSlowIn,
        //   child: Padding(
        //     padding: const EdgeInsets.only(bottom: 10),
        //     child: BottomPriceBar(
        //       barType: BottomPriceBarType.cart,
        //       cart: widget.cart,
        //     ),
        //   ),
        // ),

        // SlideTransition(
        //   position: offset,
        //   child: const Padding(
        //     padding: EdgeInsets.only(bottom: 10),
        //     child: BottomPriceBar(barType: BottomPriceBarType.cart),
        //   ),
        // ),
      ],
    );
  }
}

class LoadProductsView extends StatelessWidget {
  const LoadProductsView({Key? key, required this.products, this.cart})
      : super(key: key);

  final List<Product> products;
  final Cart? cart;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return BlocProvider(
            create: (BuildContext context) =>
                HitProductsBloc(ProductsUninitializedState()),
            child: const HorizontalFoodList(),
          );
        } else if (index == 1) {
          return ProductCategoryScroller();
        }
        if (cart != null && index == products.length + 2) {
          return const SizedBox(
            height: 50,
          );
        } else {
          final product = products[index - 2];
          return FoodVerticalListItem(
            product: product,
          );
        }
      },
      itemCount: products.length + (cart == null ? 2 : 3),
    );
  }
}
