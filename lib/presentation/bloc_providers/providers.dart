import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:withtalk_mobile/presentation/cubits/app_theme_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/announcement/cubit/announcement_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/announcement_edit/cubit/announcement_edit_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/choose_language/cubit/choose_language_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/cotegory/cubit/cotegory_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/favatires/cubit/favorites_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/forum/cubit/forum_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/forum_detail/cubit/forum_detail_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/intro/cubit/intro_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/login/cubit/login_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/main/cubit/main_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/profile/cubit/profile_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/registration/cubit/registration_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/search/cubit/search_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/user_self_announ/cubit/user_self_announ_cubit.dart';
import '../pages/my_forum/forum_list/cubit/my_forum_cubit.dart';
import '../pages/splash_page/cubit/splash_cubit.dart';

providers(BuildContext context) {
  return [
    BlocProvider<SplashCubit>(
      create: (BuildContext context) => SplashCubit(),
    ),
    BlocProvider<AppThemeCubit>(
      create: (BuildContext context) => AppThemeCubit(),
    ),
    BlocProvider<ChooseLanguageCubit>(
      create: (BuildContext context) => ChooseLanguageCubit(),
    ),
    BlocProvider<DashboardCubit>(
      create: (BuildContext context) => DashboardCubit(),
    ),
    BlocProvider<IntroCubit>(
      create: (BuildContext context) => IntroCubit(),
    ),
    BlocProvider<MainCubit>(
      create: (BuildContext context) => MainCubit(),
    ),
    BlocProvider<ProfileCubit>(
      create: (BuildContext context) => ProfileCubit(),
    ),
    BlocProvider<RegistrationCubit>(
      create: (BuildContext context) => RegistrationCubit(),
    ),
    BlocProvider<LoginCubit>(
      create: (BuildContext context) => LoginCubit(),
    ),
    BlocProvider<CotegoryCubit>(
      create: (BuildContext context) => CotegoryCubit(),
    ),
    BlocProvider<AnnouncementCubit>(
      create: (BuildContext context) => AnnouncementCubit(),
    ),
    BlocProvider<FavoritesCubit>(
      create: (BuildContext context) => FavoritesCubit(),
    ),
    BlocProvider<UserSelfAnnounCubit>(
      create: (BuildContext context) => UserSelfAnnounCubit(),
    ),
    BlocProvider<AnnouncemenEditCubit>(
      create: (BuildContext context) => AnnouncemenEditCubit(),
    ),
    BlocProvider<EditProfileCubit>(
      create: (BuildContext context) => EditProfileCubit(),
    ),
    BlocProvider<SearchCubit>(
      create: (BuildContext context) => SearchCubit(),
    ),
    BlocProvider<ForumCubit>(
      create: (BuildContext context) => ForumCubit(),
    ),
    BlocProvider<ForumDetailCubit>(
      create: (BuildContext context) => ForumDetailCubit(),
    ),
    BlocProvider<MyForumCubit>(
      create: (BuildContext context) => MyForumCubit(),
    ),
  ];
}
