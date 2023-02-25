import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:withtalk_mobile/presentation/components/app_select_cotegory.dart';
import 'package:withtalk_mobile/presentation/pages/cotegory/cotegory_page.dart';
import 'package:withtalk_mobile/presentation/pages/dashboard/dashboard_page.dart';
import 'package:withtalk_mobile/presentation/pages/edit_profile/edit_profile_page.dart';
import 'package:withtalk_mobile/presentation/pages/forum/forum_page.dart';
import 'package:withtalk_mobile/presentation/pages/forum_detail/forum_detail_page.dart';
import 'package:withtalk_mobile/presentation/pages/intro/intro_page.dart';
import 'package:withtalk_mobile/presentation/pages/my_forum/forum_list/my_forum_page.dart';
import 'package:withtalk_mobile/presentation/pages/product_detail/product_detail_page.dart';
import 'package:withtalk_mobile/presentation/pages/registration/registration_page.dart';
import 'package:withtalk_mobile/presentation/pages/search/search_page.dart';
import 'package:withtalk_mobile/presentation/pages/user_self_announ/user_self_announ_page.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';

import '../pages/announcement_edit/announcement_edit_page.dart';
import '../pages/choose_language/choose_language_page.dart';
import '../pages/login/login_page.dart';
import '../pages/splash_page/splash_page.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    args.set = settings.arguments;

    switch (settings.name) {
      case SplashPage.route:
        return PageTransition(
          child: SplashPage(),
          alignment: Alignment.center,
          type: PageTransitionType.scale,
          settings: settings,
        );

      case ChooseLanguagePage.route:
        return PageTransition(
          child: ChooseLanguagePage(),
          alignment: Alignment.center,
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

      case IntroPage.route:
        return PageTransition(
          child: IntroPage(),
          alignment: Alignment.center,
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

      case DashboardPage.route:
        return PageTransition(
          child: DashboardPage(),
          alignment: Alignment.center,
          type: PageTransitionType.scale,
          settings: settings,
        );

      case ProductDetailPage.route:
        return PageTransition(
          child: const ProductDetailPage(),
          alignment: Alignment.center,
          type: PageTransitionType.bottomToTop,
          settings: settings,
        );

      case RegistrationPage.route:
        return PageTransition(
          child: RegistrationPage(),
          alignment: Alignment.center,
          type: PageTransitionType.bottomToTop,
          settings: settings,
        );
      case LoginPage.route:
        return PageTransition(
          child: LoginPage(),
          alignment: Alignment.center,
          type: PageTransitionType.bottomToTop,
          settings: settings,
        );

      case CotegoryPage.route:
        return PageTransition(
          child: CotegoryPage(),
          alignment: Alignment.center,
          type: PageTransitionType.bottomToTop,
          settings: settings,
        );

      case AppSelectCotegoryView.route:
        return PageTransition(
          child: const AppSelectCotegoryView(),
          alignment: Alignment.center,
          type: PageTransitionType.bottomToTop,
          settings: settings,
        );
      case UserSelfAnnounPage.route:
        return PageTransition(
          child: UserSelfAnnounPage(),
          alignment: Alignment.center,
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );

      case AnnouncementEditPage.route:
        return PageTransition(
          child: AnnouncementEditPage(),
          alignment: Alignment.center,
          type: PageTransitionType.bottomToTop,
          settings: settings,
        );
      case EditProfilePage.route:
        return PageTransition(
          child: EditProfilePage(),
          alignment: Alignment.center,
          type: PageTransitionType.bottomToTop,
          settings: settings,
        );
      case SearchPage.route:
        return PageTransition(
          child: SearchPage(),
          alignment: Alignment.center,
          type: PageTransitionType.bottomToTop,
          settings: settings,
        );
      case ForumPage.route:
        return PageTransition(
          child: ForumPage(),
          alignment: Alignment.center,
          type: PageTransitionType.bottomToTop,
          settings: settings,
        );
      case ForumDetailPage.route:
        return PageTransition(
          child: ForumDetailPage(),
          alignment: Alignment.center,
          type: PageTransitionType.bottomToTop,
          settings: settings,
        );
      case MyForumPage.route:
        return PageTransition(
          child: MyForumPage(),
          alignment: Alignment.center,
          type: PageTransitionType.bottomToTop,
          settings: settings,
        );

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
