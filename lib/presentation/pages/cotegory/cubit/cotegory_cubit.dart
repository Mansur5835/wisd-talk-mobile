import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:withtalk_mobile/core/utils/pagination_maker.dart';
import 'package:withtalk_mobile/data/models/product.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';

import '../../../components/app_cubit.dart';

part 'cotegory_state.dart';

class CotegoryCubit extends AppCubit<CotegoryState> {
  CotegoryCubit() : super(CotegoryState());

  PaginationMaker _paginationMaker = PaginationMaker();

  @override
  void init() {
    emit(state.copyWith(state..name = args.get["name"]));
    _loadData();
  }

  _loadData() async {
    emit(state.copyWith(state..isLoading = true));

    var response = await client.products(categoryId: args.get["id"]);
    _paginationMaker.pageSize = response.data?.pagination?.pageCount ?? 0;

    emit(state.copyWith(state
      ..isLoading = false
      ..products = response.data?.info));
  }

  Future<void> loadMore() async {
    if (_paginationMaker.isLast) {
      return;
    }
    var response = await client.products(size: 10, page: _paginationMaker.page);

    emit(state.copyWith(state..products?.addAll(response.data?.info ?? [])));
  }

  @override
  void dispose() {
    _paginationMaker.page = 0;
  }
}
