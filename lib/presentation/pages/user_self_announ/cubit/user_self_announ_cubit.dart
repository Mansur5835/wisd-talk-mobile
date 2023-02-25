import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:withtalk_mobile/core/utils/pagination_maker.dart';
import 'package:withtalk_mobile/data/models/app_http_response.dart';
import 'package:withtalk_mobile/data/models/pagination.dart';
import 'package:withtalk_mobile/data/models/product.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';

import '../../../components/app_cubit.dart';

part 'user_self_announ_state.dart';

class UserSelfAnnounCubit extends AppCubit<UserSelfAnnounState> {
  static const String route = "/user_self_announ_page";
  UserSelfAnnounCubit() : super(UserSelfAnnounState());

  bool isOtherUser = false;
  String? id;

  PaginationMaker paginationMaker = PaginationMaker();

  @override
  void init() {
    isOtherUser = args.get["user"];
    id = args.get["id"];
    emit(state.copyWith(state..title = args.get["title"]));
    loadData();
  }

  loadData() async {
    paginationMaker.page = 0;
    emit(state.copyWith(state..isLoading = true));

    AppHttpResponse<Pagination<ProductModel>>? response;

    if (isOtherUser) {
      response = await client.userProducts(userId: id);
    } else {
      response = await client.myProducts();
    }

    paginationMaker.pageSize = response.data?.pagination?.pageCount ?? 0;

    emit(state.copyWith(state
      ..products = response.data?.info
      ..isLoading = false));
  }

  Future<void> loadMore() async {
    if (paginationMaker.isLast) {
      return;
    }

    AppHttpResponse<Pagination<ProductModel>>? response;

    if (isOtherUser) {
      response = await client.userProducts(
          userId: id, size: 10, page: paginationMaker.page);
    } else {
      response = await client.myProducts(size: 10, page: paginationMaker.page);
    }

    emit(state.copyWith(state..products?.addAll(response.data?.info ?? [])));
  }

  @override
  void dispose() {
    paginationMaker.page = 0;
  }
}
