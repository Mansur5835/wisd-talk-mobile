part of 'user_self_announ_cubit.dart';

class UserSelfAnnounState {
  bool isLoading;
  List<ProductModel>? products;
  String? title;

  UserSelfAnnounState([
    this.isLoading = false,
    this.products,
    this.title,
  ]);

  UserSelfAnnounState copyWith(UserSelfAnnounState state) {
    return UserSelfAnnounState(
      state.isLoading,
      state.products,
      state.title,
    );
  }
}
