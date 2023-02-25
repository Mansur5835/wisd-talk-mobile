part of 'edit_profile_cubit.dart';

class EditProfileState {
  String? code;
  String? countiryImage;
  File? image;

  EditProfileState([this.code, this.countiryImage, this.image]);

  EditProfileState copyWith(EditProfileState state) {
    return EditProfileState(state.code, state.countiryImage, state.image);
  }
}
