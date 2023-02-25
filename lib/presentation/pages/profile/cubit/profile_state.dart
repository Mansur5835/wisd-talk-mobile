part of 'profile_cubit.dart';

class ProfileState {
  bool startAnim;
  ProfileState([this.startAnim = false]);

  ProfileState copyWith(ProfileState state) {
    return ProfileState(state.startAnim);
  }
}
