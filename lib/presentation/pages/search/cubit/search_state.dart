part of 'search_cubit.dart';

class SearchState {
  SearchCase serachCases;
  List<ProductModel>? products;
  int? foundProducts;
  SearchState(
      [this.serachCases = SearchCase.none, this.products, this.foundProducts]);

  SearchState copyWith(SearchState state) {
    return SearchState(state.serachCases, state.products, state.foundProducts);
  }
}
