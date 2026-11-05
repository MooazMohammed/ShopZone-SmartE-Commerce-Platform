import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/features/products/data/models/product_model.dart';
import 'package:storeapp/features/products/data/repos/products_repo.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo repo;

  ProductsCubit(this.repo) : super(ProductsInitial());

  /// Fetch the full product catalogue.
  Future<void> fetchAllProducts() async {
    emit(ProductsLoading());
    try {
      final products = await repo.getAllProducts();
      emit(ProductsSuccess(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  /// Fetch products filtered by [category].
  Future<void> fetchProductsByCategory(String category) async {
    emit(ProductsLoading());
    try {
      final products = await repo.getProductsByCategory(category);
      emit(ProductsSuccess(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
