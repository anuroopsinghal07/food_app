import 'package:flutter/material.dart';
import 'package:food_app/AppDrawer/app_drawer.dart';
import 'package:food_app/Bloc/CartBloc/cart_bloc.dart';
import 'package:food_app/Bloc/CartBloc/cart_event.dart';
import 'package:food_app/Bloc/CartBloc/cart_state.dart';
import 'package:food_app/Bloc/ProductBloc/product_state.dart';
import 'package:food_app/Bloc/ProductBloc/products_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/widgets/ProductList/product_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) =>
                ProductsBloc(ProductsUninitializedState()),
          ),
          BlocProvider(
              create: (BuildContext context) =>
                  CartBloc(CartUninitializedState())),
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.grey.shade800),
            title: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color: Colors.black,
                child: Center(
                  child: Text(
                    '100a Ealing Rd · 24 mins',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.search),
              ),
            ],
          ),
          body: const SafeArea(
            child: ProductListWidget(),
          ),
          drawer: const AppDrawer(),
        ));

    // BlocProvider(
    //     create: (BuildContext context) =>
    //         ProductsBloc(ProductsUninitializedState()),
    //     );
  }
}
