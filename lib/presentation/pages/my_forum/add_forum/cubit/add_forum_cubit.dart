import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:withtalk_mobile/data/models/cotegory.dart';
import 'package:withtalk_mobile/data/models/forum.dart';
import 'package:withtalk_mobile/presentation/components/app_toast.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';

import '../../../../../data/constants/enums.dart';

part 'add_forum_state.dart';

class AddForumCubit extends Cubit<AddForumState> {
  AddForumCubit() : super(AddForumState());

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ForumModel? forumModel;

  init(ForumModel? _forumModel) async {
    if (_forumModel == null) return;

    emit(state.copyWith(state..isLoading = true));
    var response = await client.forum(forumId: _forumModel.id);

    forumModel = response.data?.first;

    name.text = forumModel?.name ?? "";
    description.text = forumModel?.detailText ?? "";
    _setCotegory(forumModel?.sectionId);
  }

  _setCotegory(String? id) async {
    var response = await client.subCategory(categoryId: id);

    emit(state.copyWith(state
      ..cotegoryModel = response.data?.first
      ..isLoading = false));
  }

  bool chackInfos() {
    bool isValid = formKey.currentState?.validate() ?? false;
    List<AddForumErrors> list = [];

    if (state.cotegoryModel == null) {
      list.add(AddForumErrors.cotegory);
    }
    emit(state.copyWith(state..addForumErrors = list));

    return isValid && list.isEmpty;
  }

  addForum() async {
    if (chackInfos() == false) return;

    loading.showLoading();

    var response = await client.forumAction(
        action: forumModel == null ? "add" : "edit",
        detailText: description.text,
        subCategory: state.cotegoryModel?.categoryId,
        title: name.text,
        forumId: forumModel?.id);

    if (response.data == null) return;

    loading.hideLoading();

    AppToast appToast = AppToast();
    clear();

    appToast.succesToast(
        forumModel != null ? "forum_changed".tr() : "forum_added".tr());
  }

  deleteForum() async {
    loading.showLoading();
    var response =
        await client.forumAction(action: "delete", forumId: forumModel?.id);

    if (response.data == null) return;

    loading.hideLoading();
    AppNavigator.back();
  }

  clear() {
    name.clear();
    description.clear();
    emit(state.copyWith(state..cotegoryModel = null));
  }

  setCotegory(CotegoryModel? cotegory) {
    emit(state.copyWith(state..cotegoryModel = cotegory));
  }

  bool chackEditOrAdd() {
    return forumModel == null;
  }
}
