part of 'dashboard_cubit.dart';

class DashboardState {
  int currentPageIndex;
  User? user;

  DashboardState([this.currentPageIndex = 0, this.user]);

  DashboardState copyWith(DashboardState state) {
    return DashboardState(state.currentPageIndex, state.user);
  }
}
