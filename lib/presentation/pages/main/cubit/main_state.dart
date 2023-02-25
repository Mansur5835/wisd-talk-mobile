part of 'main_cubit.dart';

class MainState {
  List<CotegoryModel>? cotegoties;
  List<CotegoryModel>? forums;
  List<ProductModel>? products;
  bool hideSearchBar;
  String scrollDirection;
  bool isLoading;
  int indexForum;
  double height;

  MainState(
      [this.cotegoties,
      this.products,
      this.hideSearchBar = false,
      this.scrollDirection = "none",
      this.isLoading = false,
      this.forums,
      this.indexForum = 0,
      this.height = 0]);

  MainState copyWith(MainState state) {
    return MainState(
        state.cotegoties,
        state.products,
        state.hideSearchBar,
        state.scrollDirection,
        state.isLoading,
        state.forums,
        state.indexForum,
        state.height);
  }
}
