import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';

import '../../../../data/models/user.dart';
import '../../../components/loading_view_mixin.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState());

  final PageController pageController = PageController();

  void init() {
    emit(state.copyWith(state..user = args.get));
  }

  void onChangesPage(int index) {
    emit(state.copyWith(state..currentPageIndex = index));
  }

  void jumpToPAge(int index) {
    pageController.jumpToPage(index);
  }

  loadUserDataAgain() async {
    var response = await client.profile();

    if (response.data == null) return;

    emit(state.copyWith(state..user = response.data));
  }

  void dispose() {
    // TODO: implement dispose
  }
}
