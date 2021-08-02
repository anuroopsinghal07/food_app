import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Bloc/ProductBloc/product_event.dart';
import 'package:food_app/Bloc/product_state.dart';
import 'package:food_app/Model/product.dart';
import 'package:food_app/Repository/product_repository.dart';

class HitProductsBloc extends Bloc<HitProductsFetchEvent, ProductState> {
  final ProductRepository productRepository = ProductRepository();

  HitProductsBloc(ProductState initialState) : super(initialState);
  @override
  void onTransition(
      Transition<HitProductsFetchEvent, ProductState> transition) {
    super.onTransition(transition);
  }

  // @override
  // ProductState get initialState => ProductsUninitializedState();

  @override
  Stream<ProductState> mapEventToState(HitProductsFetchEvent event) async* {
    yield ProductsFetchingState();
    List<Product>? products;
    try {
      products = await productRepository.fetchProducts(true);
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
