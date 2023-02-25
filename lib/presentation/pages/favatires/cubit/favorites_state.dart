part of 'favorites_cubit.dart';

class FavoritesState {
  bool isLoading;
  List<ProductModel>? products;

  FavoritesState([this.isLoading = false, this.products]);

  FavoritesState copyWith(FavoritesState state) {
    return FavoritesState(state.isLoading, state.products);
  }
}
