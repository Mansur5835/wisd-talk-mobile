import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:withtalk_mobile/core/utils/pagination_maker.dart';
import 'package:withtalk_mobile/data/models/product_detail.dart';
import 'package:withtalk_mobile/data/models/rating.dart';
import 'package:withtalk_mobile/data/models/review.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(ProductDetailState());

  String? id;

  PaginationMaker _paginationMaker = PaginationMaker();

  init() {
    id = args.get["id"];
    List<String> images = [args.get["image"]?["src"] ?? ""];
    emit(state.copyWith(state.copyWith(state..images = images)));

    _loadData();
    _loadReviews();
  }

  _loadData() async {
    emit(state.copyWith(state..isLoading = true));

    var response = await client.product(productId: id ?? "");

    List<String> list =
        List.generate(response.data?.first.morePhotos?.length ?? 0, (index) {
      return response.data?.first.morePhotos?[index]["src"];
    });

    emit(state.copyWith(state
      ..productDetailModel = response.data?.first
      ..isLoading = false
      ..images?.addAll(list)));
  }

  _loadReviews() async {
    var response = await client.comments(productId: id);

    _paginationMaker.pageSize = response.data?.pagination?.pageCount ?? 0;

    emit(state.copyWith(state..reviews = response.data?.info));
  }

  loadMore() async {
    var response = await client.comments(
        productId: id, size: 10, page: _paginationMaker.page);

    emit(state.copyWith(state..reviews?.addAll(response.data?.info ?? [])));
  }

  leaveReaview(Rating rating) async {
    client
        .comment(productId: id, rating: rating.rating, text: rating.comment)
        .then((value) {
      _loadReviews();
    });
  }
}
