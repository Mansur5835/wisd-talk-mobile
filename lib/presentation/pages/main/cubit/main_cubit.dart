import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:withtalk_mobile/core/utils/pagination_maker.dart';
import 'package:withtalk_mobile/data/models/cotegory.dart';
import 'package:withtalk_mobile/data/models/product.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';
import '../../../components/app_cubit.dart';
part 'main_state.dart';

class MainCubit extends AppCubit<MainState> {
  MainCubit() : super(MainState());
  final ScrollController scrollController = ScrollController();

  final PaginationMaker _paginationMaker = PaginationMaker();

  PageController pageController = PageController();

  @override
  void init() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        emit(state.copyWith(state..hideSearchBar = true));
      } else {
        emit(state.copyWith(state..hideSearchBar = false));
      }
    });
    _loadData();
  }

  _loadData() async {
    emit(state.copyWith(state..isLoading = true));
    client.cotigories().then((response) {
      emit(state.copyWith(state..cotegoties = response.data));
    });

    client.products(page: _paginationMaker.page, size: 10).then((response) {
      _paginationMaker.pageSize = response.data?.pagination?.pageCount ?? 0;
      emit(state.copyWith(state
        ..products = response.data?.info
        ..isLoading = false));
    });

    client.cotegoryOfForum().then((value) {
      emit(state.copyWith(state..forums = value.data));
    });
  }

  forumIndexTap(int index) {
    pageController.animateToPage(index,
        curve: Curves.bounceInOut, duration: const Duration(milliseconds: 200));
    emit(state.copyWith(state..indexForum = index));
  }

  pageChanging(int index) {
    emit(state.copyWith(state..indexForum = index));
  }

  Future<void> loadMore() async {
    if (_paginationMaker.isLast) {
      return;
    }
    var response = await client.products(size: 10, page: _paginationMaker.page);

    emit(state.copyWith(state..products?.addAll(response.data?.info ?? [])));
  }

  void logicHaight(int count, bool isLoading) {
    double _height = isLoading ? 150 : count * 50;
    emit(state.copyWith(state..height = _height));
  }

  @override
  void dispose() {
    _paginationMaker.page = 0;
    emit(MainState());
  }
}
