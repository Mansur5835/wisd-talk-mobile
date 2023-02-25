part of 'intro_cubit.dart';

class IntroState {
  int index;
  bool indexChanged;
  String image;
  Map<String, String> title;
  IntroState(
      [this.index = -1,
      this.indexChanged = true,
      this.image = "assets/images/job.png",
      this.title = const {"title": "work_title", "body": "work_body"}]);

  IntroState copyWith(IntroState state) {
    return IntroState(
        state.index, state.indexChanged, state.image, state.title);
  }
}
