import 'package:withtalk_mobile/core/utils/assets_manager.dart';
import 'package:withtalk_mobile/presentation/pages/dashboard/dashboard_page.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';

import '../../../components/app_cubit.dart';
part 'intro_state.dart';

class IntroCubit extends AppCubit<IntroState> {
  IntroCubit() : super(IntroState());

  List<Map<String, String>> titles = [
    {"title": "work_title", "body": "work_body"},
    {"title": "moth_child_title", "body": "moth_child_body"},
    {"title": "consulting_title", "body": "consulting_body"},
  ];

  List<String> images = [
    AssetsManager.images(name: "job"),
    AssetsManager.images(name: "moth_and_child"),
    AssetsManager.images(name: "student")
  ];

  @override
  void init() {
    setIndex();
  }

  void setIndex() async {
    int index = state.index + 1;

    if (index > 2) {
      AppNavigator.toNamedAndOffAll(DashboardPage.route);
    }
    emit(state.copyWith(state
      ..index = index
      ..indexChanged = true));

    Future.delayed(const Duration(milliseconds: 700), () {
      emit(state.copyWith(state
        ..indexChanged = false
        ..image = images[index]
        ..title = titles[index]));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
