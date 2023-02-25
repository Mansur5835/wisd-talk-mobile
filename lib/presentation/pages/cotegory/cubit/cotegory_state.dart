part of 'cotegory_cubit.dart';

class CotegoryState {
  bool isLoading;
  String? name;
  List<ProductModel>? products;
  CotegoryState([this.isLoading = false, this.products, this.name]);

  CotegoryState copyWith(CotegoryState state) {
    return CotegoryState(state.isLoading, state.products, state.name);
  }
}
