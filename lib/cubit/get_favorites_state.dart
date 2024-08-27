part of 'get_favorites_cubit.dart';

@immutable
sealed class GetFavoritesState {}

final class GetFavoritesInitial extends GetFavoritesState {}

final class GetFavoritesLoading extends GetFavoritesState {}

final class GetFavoritesSuccess extends GetFavoritesState {
  final Map<String, Map<String, dynamic>> favoriteList;
  GetFavoritesSuccess({required this.favoriteList});
}

final class GetFavoritesFailure extends GetFavoritesState {
  final String error;

  GetFavoritesFailure({required this.error});
}
