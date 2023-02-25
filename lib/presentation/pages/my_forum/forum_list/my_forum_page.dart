import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:withtalk_mobile/presentation/components/app_load_item_widget.dart';
import 'package:withtalk_mobile/presentation/components/app_page.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_widget.dart';
import 'package:withtalk_mobile/presentation/components/views/forum_view.dart';
import 'package:withtalk_mobile/presentation/pages/my_forum/add_forum/add_forum_page.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_colors.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';

import 'cubit/my_forum_cubit.dart';

class MyForumPage extends AppPage<MyForumCubit, MyForumState> {
  static const String route = "/my_forum_page";
  MyForumPage({super.key});

  @override
  Widget build(BuildContext context, state) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor(context),
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor(context),
        leading: GestureDetector(
          onTap: () {
            AppNavigator.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: AppTheme.oppositePrimaryColor(context),
          ),
        ),
        title: AppText(
          "forums".tr(),
          fontWeight: FontWeight.bold,
          color: AppTheme.oppositePrimaryColor(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () async {
          await AppNavigator.to(const AddForumPage());
          cubit.loadData();
        },
        child: const Icon(Icons.add),
      ),
      body: state.isLoading
          ? const Center(
              child: LoadingViewWidget(
                radius: 50,
              ),
            )
          : Container(
              child: Column(
                children: [
                  AppLoadItemView(
                      isGrid: false,
                      items: List.generate(state.forums?.length ?? 0, (index) {
                        return ForumView(
                          updateUI: () {
                            cubit.loadData();
                          },
                          isEdit: true,
                          forumModel: state.forums![index],
                        );
                      }))
                ],
              ),
            ),
    );
  }
}
