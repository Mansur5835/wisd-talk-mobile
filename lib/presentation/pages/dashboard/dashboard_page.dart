import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:withtalk_mobile/core/utils/bloc_logic.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/views/navigation_item_view.dart';
import 'package:withtalk_mobile/presentation/pages/announcement/announcement_page.dart';
import 'package:withtalk_mobile/presentation/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';

import '../favatires/favorites_page.dart';
import '../main/main_page.dart';
import '../profile/profile_page.dart';

class DashboardPage extends StatefulWidget {
  static const String route = "/dashboard_page";
  DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final cubit = BlocLogic<DashboardCubit>()();
  @override
  void initState() {
    super.initState();
    cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppTheme.primaryColor(context),
          body: SafeArea(
            child: Stack(
              children: [_pages(), _bottomNavBar(state, context)],
            ),
          ),
        );
      },
    );
  }

  Widget _bottomNavBar(DashboardState state, BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: AppTheme.primaryColor(context)),
        child: Row(
          children: [
            NavigationItemView(
              icon: "home_none",
              activeIcon: "home",
              label: "home".tr(),
              selected: state.currentPageIndex == 0,
              onTab: () {
                cubit.jumpToPAge(0);
              },
            ),
            NavigationItemView(
              icon: "heart",
              activeIcon: "love",
              label: "favorites".tr(),
              selected: state.currentPageIndex == 1,
              onTab: () {
                cubit.jumpToPAge(1);
              },
            ),
            NavigationItemView(
              icon: "add_none",
              activeIcon: "add",
              label: "announcement".tr(),
              selected: state.currentPageIndex == 2,
              onTab: () {
                cubit.jumpToPAge(2);
              },
            ),
            NavigationItemView(
              icon: "chat_none",
              activeIcon: "chat",
              label: "messages".tr(),
              // withBadge: true,
              selected: state.currentPageIndex == 3,
              onTab: () {
                cubit.jumpToPAge(3);
              },
            ),
            NavigationItemView(
              icon: "user_none",
              activeIcon: "user",
              label: "profile".tr(),
              selected: state.currentPageIndex == 4,
              onTab: () {
                cubit.jumpToPAge(4);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _pages() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          cubit.onChangesPage(value);
        },
        controller: cubit.pageController,
        children: [
          MainPage(),
          FavoritePage(),
          AnnouncementPage(),
          Container(
            alignment: Alignment.center,
            child: AppText("Xabarlar"),
          ),
          ProfilePage()
        ],
      ),
    );
  }
}
