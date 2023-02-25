import 'package:flutter/material.dart';
import 'package:withtalk_mobile/data/models/forum.dart';
import 'package:withtalk_mobile/data/models/forum_message.dart';
import 'package:withtalk_mobile/main.dart';
import 'package:withtalk_mobile/presentation/components/app_dialog.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';
import 'package:withtalk_mobile/presentation/components/views/has_not_user_action_view,.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import '../../../components/app_cubit.dart';
part 'forum_detail_state.dart';

class ForumDetailCubit extends AppCubit<ForumDetailState> {
  ForumDetailCubit() : super(ForumDetailState());

  TextEditingController message = TextEditingController();
  ScrollController scrollController = ScrollController();
  FocusNode focusNode = FocusNode();

  EditAction actionEdit = EditAction();

  @override
  void init() {
    message.addListener(writeViewHeight);
    emit(state.copyWith(state..forumModel = args.get));
    _loadData();
  }

  writeViewHeight() {
    int lineSize = ((message.text.length) / 30).floor();

    emit(state.copyWith(state..height = 60 + lineSize * 15));
  }

  _loadData() async {
    emit(state.copyWith(state..isLoading = true));

    var response = await client.forumMessages(
        forumId: state.forumModel?.id, page: 1, size: 1000);

    emit(state.copyWith(state
      ..isLoading = false
      ..messages = response.data?.info));
  }

  send() async {
    if (!hasUser) {
      const AppDialog(child: HasNotUserAvtionView()).show();
    }

    if (message.text.replaceAll(" ", "").isEmpty) {
      return;
    }

    await client.forumMessageAction(
        action: "add",
        forumId: state.forumModel?.id,
        text: message.text,
        answer: state.forumMessageModel?.id);

    var response = await client.forumMessages(
        forumId: state.forumModel?.id, page: 1, size: 1000);

    emit(state.copyWith(state
      ..messages = response.data?.info
      ..forumMessageModel = null));

    message.clear();

    scrollController.animateTo(scrollController.position.maxScrollExtent + 100,
        curve: Curves.linear, duration: const Duration(milliseconds: 200));
  }

  forwerd(ForumMessageModel? messageModel) {
    focusNode.requestFocus();
    emit(state.copyWith(state..forumMessageModel = messageModel));
  }

  deleteMessage(ForumMessageModel? messageModel) async {
    await client.forumMessageAction(
      action: "delete",
      messageId: messageModel?.id,
    );

    var response = await client.forumMessages(
        forumId: state.forumModel?.id, page: 1, size: 1000);

    emit(state.copyWith(state
      ..messages = response.data?.info
      ..forumMessageModel = null));
  }

  editMessage(ForumMessageModel? messageModel) async {
    if (actionEdit.action) {
      await client.forumMessageAction(
        action: "edit",
        messageId: actionEdit.id,
        text: message.text,
      );

      var response = await client.forumMessages(
          forumId: state.forumModel?.id, page: 1, size: 1000);

      emit(state.copyWith(state
        ..messages = response.data?.info
        ..forumMessageModel = null));

      message.clear();
      actionEdit.action = false;
    } else {
      message.text = messageModel?.text ?? "";
      actionEdit.id = messageModel?.id;
      actionEdit.action = true;
    }
  }

  removeForwerd(BuildContext context) {
    emit(state.copyWith(state..forumMessageModel = null));
  }

  @override
  void dispose() {
    emit(ForumDetailState());
    message.clear();
    focusNode.dispose();
  }
}

class EditAction {
  bool action = false;
  String? id;
}
