part of 'forum_cubit.dart';

class ForumState {
  String? name;
  bool isLoading;
  List<ForumModel>? forums;
  ForumState([this.name, this.isLoading = false, this.forums]);

  ForumState copyWith(ForumState state) {
    return ForumState(state.name, state.isLoading, state.forums);
  }
}
