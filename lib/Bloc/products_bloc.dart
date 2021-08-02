import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Bloc/ProductBloc/product_event.dart';
import 'package:food_app/Bloc/ProductBloc/product_state.dart';
import 'package:food_app/Model/product.dart';
import 'package:food_app/Repository/product_repository.dart';

class ProductsBloc extends Bloc<ProductsFetchEvent, ProductState> {
  final ProductRepository productRepository = ProductRepository();

  ProductsBloc(ProductState initialState) : super(initialState);
  @override
  void onTransition(Transition<ProductsFetchEvent, ProductState> transition) {
    super.onTransition(transition);
  }

  // @override
  // ProductState get initialState => ProductsUninitializedState();

  @override
  Stream<ProductState> mapEventToState(ProductsFetchEvent event) async* {
    yield ProductsFetchingState();
    List<Product>? products;
    try {
      products = await productRepository.fetchProducts(false);
      if (products == null) {
        yield ProductsEmptyState();
      } else {
        yield ProductsFetchedState(products: products);
      }
    } catch (e) {
      yield ProductsErrorState();
    }
  }
}
