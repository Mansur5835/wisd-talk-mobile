part of 'my_forum_cubit.dart';

class MyForumState {
  List<ForumModel>? forums;
  bool isLoading;

  MyForumState([this.forums, this.isLoading = false]);

  MyForumState copyWith(MyForumState state) {
    return MyForumState(state.forums, state.isLoading);
  }
}
