part of 'add_forum_cubit.dart';

class AddForumState {
  CotegoryModel? cotegoryModel;
  List<AddForumErrors>? addForumErrors;
  bool isLoading;

  AddForumState(
      [this.cotegoryModel, this.addForumErrors, this.isLoading = false]);

  AddForumState copyWith(AddForumState state) {
    return AddForumState(
        state.cotegoryModel, state.addForumErrors, state.isLoading);
  }
}
