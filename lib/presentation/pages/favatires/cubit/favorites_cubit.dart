import 'package:withtalk_mobile/core/utils/pagination_maker.dart';
import 'package:withtalk_mobile/data/models/product.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';

import '../../../components/app_cubit.dart';

part 'favorites_state.dart';

class FavoritesCubit extends AppCubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesState());

  PaginationMaker paginationMaker = PaginationMaker();

  @override
  void init() {
    loadData();
  }

  loadData() async {
    paginationMaker.page = 0;
    emit(state.copyWith(state..isLoading = true));

    var response = await client.listFavorite();

    paginationMaker.pageSize = response.data?.pagination?.pageCount ?? 0;

    emit(state.copyWith(state
      ..products = response.data?.info
      ..isLoading = false));
  }

  Future<void> loadMore() async {
    if (paginationMaker.isLast) {
      return;
    }
    var response = await client.products(size: 10, page: paginationMaker.page);

    emit(state.copyWith(state..products?.addAll(response.data?.info ?? [])));
  }

  @override
  void dispose() {
    paginationMaker.page = 0;
  }
}
