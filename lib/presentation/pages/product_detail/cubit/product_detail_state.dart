part of 'product_detail_cubit.dart';

class ProductDetailState {
  List<String>? images;
  ProductDetailModel? productDetailModel;
  bool isLoading;
  List<ReviewModel>? reviews;

  ProductDetailState(
      [this.images,
      this.productDetailModel,
      this.isLoading = false,
      this.reviews]);

  ProductDetailState copyWith(ProductDetailState state) {
    return ProductDetailState(
        state.images, state.productDetailModel, state.isLoading, state.reviews);
  }
}
