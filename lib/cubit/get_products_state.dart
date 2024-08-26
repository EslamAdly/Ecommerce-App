part of 'get_products_cubit.dart';

@immutable
sealed class GetProductsState {}

final class GetProductsInitial extends GetProductsState {}

final class GetProductsLoading extends GetProductsState {}

final class GetProductsSuccess extends GetProductsState {
  final List<Product> productList;
  final List<String> categories;

  GetProductsSuccess({required this.productList, required this.categories});
}

final class GetProductsFailure extends GetProductsState {
  final String error;

  GetProductsFailure({required this.error});
}
