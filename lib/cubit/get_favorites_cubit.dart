import 'package:bloc/bloc.dart';
import 'package:ecommerce/services/FireBaseHelper.dart';
import 'package:meta/meta.dart';

part 'get_favorites_state.dart';

class GetFavoritesCubit extends Cubit<GetFavoritesState> {
  GetFavoritesCubit() : super(GetFavoritesInitial());

  GetFavorites() async {
    emit(GetFavoritesLoading());
    try {
      final fireBaseHelper = FireBaseHelper();

      Map<String, Map<String, dynamic>> favoriteProducts =
          await fireBaseHelper.getFavoriteProducts();
      emit(GetFavoritesSuccess(favoriteList: favoriteProducts));
    } catch (err) {
      emit(GetFavoritesFailure(error: err.toString()));
    }
  }
}
