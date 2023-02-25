import 'package:flutter/material.dart';
import 'package:withtalk_mobile/presentation/components/animation/slide_and_opasity_animation.dart';
import 'package:withtalk_mobile/presentation/components/app_load_item_widget.dart';
import 'package:withtalk_mobile/presentation/components/app_page.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/buttons.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_widget.dart';
import 'package:withtalk_mobile/presentation/pages/forum/cubit/forum_cubit.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';

import '../../components/views/forum_view.dart';

class ForumPage extends AppPage<ForumCubit, ForumState> {
  static const String route = "/forum_page";
  ForumPage({super.key});

  @override
  Widget build(BuildContext context, state) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor(context),
      appBar: AppBar(
        elevation: 0,
        title: AppText(
          state.name,
          size: 18,
          color: AppTheme.oppositePrimaryColor(context),
        ),
        leading: CustomButton.iconButton(
            onTab: () {
              AppNavigator.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: AppTheme.oppositePrimaryColor(context),
            )),
        backgroundColor: AppTheme.primaryColor(context),
      ),
      body: state.isLoading
          ? const Center(
              child: LoadingViewWidget(
                radius: 50,
              ),
            )
          : Container(
              margin: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppLoadItemView(
                        isGrid: false,
                        items:
                            List.generate(state.forums?.length ?? 0, (index) {
                          return SlideAndOpasityAnimation(
                            opasityDuration: 80,
                            slideDuration: ((index + 1)) * 150,
                            child: ForumView(
                              updateUI: () {},
                              forumModel: state.forums![index],
                            ),
                          );
                        }))
                  ],
                ),
              ),
            ),
    );
  }
}
