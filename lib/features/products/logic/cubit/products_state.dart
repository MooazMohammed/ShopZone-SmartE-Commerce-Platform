part of 'products_cubit.dart';

sealed class ProductsState {}

/// Initial state — no request made yet.
final class ProductsInitial extends ProductsState {}

/// Request in-flight.
final class ProductsLoading extends ProductsState {}

/// Data fetched successfully.
final class ProductsSuccess extends ProductsState {
  final List<ProductModel> products;
  ProductsSuccess(this.products);
}

/// Something went wrong.
final class ProductsError extends ProductsState {
  final String message;
  ProductsError(this.message);
}
