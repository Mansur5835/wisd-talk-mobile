part of 'forum_detail_cubit.dart';

class ForumDetailState {
  ForumModel? forumModel;
  List<ForumMessageModel>? messages;
  bool isLoading;
  double height;
  ForumMessageModel? forumMessageModel;

  ForumDetailState([
    this.forumModel,
    this.messages,
    this.isLoading = false,
    this.height = 60,
    this.forumMessageModel,
  ]);

  ForumDetailState copyWith(ForumDetailState state) {
    return ForumDetailState(
      state.forumModel,
      state.messages,
      state.isLoading,
      state.height,
      state.forumMessageModel,
    );
  }
}
