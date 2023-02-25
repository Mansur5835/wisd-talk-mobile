import 'package:withtalk_mobile/core/utils/pagination_maker.dart';
import 'package:withtalk_mobile/data/models/product.dart';
import 'package:withtalk_mobile/data/models/sort_model.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';

import '../../../../data/constants/enums.dart';
import '../../../components/app_cubit.dart';

part 'search_state.dart';

class SearchCubit extends AppCubit<SearchState> {
  SearchCubit() : super(SearchState());

  PaginationMaker paginationMaker = PaginationMaker();
  String? query;

  SortModel? sortModel;

  @override
  void init() {
    // TODO: implement init
  }

  search(String? query) async {
    this.query = query;
    emit(state.copyWith(state..serachCases = SearchCase.searching));

    var response = await client.search(
      query: query,
      from: sortModel?.from,
      to: sortModel?.to,
      sort: sortModel?.sort,
    );

    paginationMaker.pageSize = response.data?.pagination?.pageSize ?? 0;

    emit(state.copyWith(
        state..foundProducts = response.data?.pagination?.totalCount ?? 0));

    if (response.data?.info?.isEmpty ?? true) {
      return emit(state.copyWith(state..serachCases = SearchCase.notFount));
    }

    emit(state.copyWith(state
      ..serachCases = SearchCase.found
      ..products = response.data?.info));
  }

  Future<void> loadMore() async {
    if (paginationMaker.isLast) return;
    var response = await client.search(
      query: query,
      size: 10,
      page: paginationMaker.page,
      from: sortModel?.from,
      to: sortModel?.to,
      sort: sortModel?.sort,
    );

    emit(state.copyWith(state..products?.addAll(response.data?.info ?? [])));
  }

  sort(SortModel? sortModel) {
    this.sortModel = sortModel;

    search(query);
  }

  @override
  void dispose() {
    emit(state.copyWith(SearchState()));
  }
}
