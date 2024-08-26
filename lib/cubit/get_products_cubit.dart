import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ecommerce/constants/ApiConstant.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/services/ProductsService.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  GetProductsCubit() : super(GetProductsInitial());

  GetProducts() async {
    emit(GetProductsLoading());
    try {
      List<Product> products = await ProductsService().getProducts(
          path: ApiConstant.baseUrl + ApiConstant.productsEndPoint);
      List<String> categories =
          products.map((product) => product.category).toSet().toList();
      emit(GetProductsSuccess(productList: products, categories: categories));
    } catch (err) {
      emit(GetProductsFailure(error: err.toString()));
    }
  }
}
