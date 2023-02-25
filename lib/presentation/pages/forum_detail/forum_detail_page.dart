import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:withtalk_mobile/presentation/components/animation/slide_and_opasity_animation.dart';
import 'package:withtalk_mobile/presentation/components/app_load_item_widget.dart';
import 'package:withtalk_mobile/presentation/components/app_network_image.dart';
import 'package:withtalk_mobile/presentation/components/app_page.dart';
import 'package:withtalk_mobile/presentation/components/buttons.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_widget.dart';
import 'package:withtalk_mobile/presentation/components/views/message_view.dart';
import 'package:withtalk_mobile/presentation/components/views/user_avatar.dart';
import 'package:withtalk_mobile/presentation/pages/forum_detail/cubit/forum_detail_cubit.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_colors.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';
import '../../components/app_text.dart';

class ForumDetailPage extends AppPage<ForumDetailCubit, ForumDetailState> {
  static const String route = "/forum_detail_page";
  ForumDetailPage({super.key});

  @override
  Widget build(BuildContext context, state) {
    return Scaffold(
        backgroundColor: AppTheme.primaryColor(context),
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: AppTheme.primaryColor(context),
          leading: CustomButton.iconButton(
              onTab: () {
                AppNavigator.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: AppTheme.oppositePrimaryColor(context),
              )),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (state.forumModel?.userPhoto == null)
                Hero(
                  tag: state.forumModel?.id ?? UniqueKey(),
                  child: UserAvatar(
                    size: 40,
                  ),
                )
              else
                Hero(
                  tag: state.forumModel?.id ?? UniqueKey(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(213),
                    child: AppNetworkImage(
                      url: state.forumModel?.userPhoto,
                      wight: 40,
                      height: 40,
                    ),
                  ),
                ),
              const SizedBox(
                width: 10,
              ),
              AppText(
                state.forumModel?.user,
                color: AppTheme.oppositePrimaryColor(context),
                size: 18,
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              state.isLoading
                  ? const Center(
                      child: LoadingViewWidget(
                        radius: 50,
                      ),
                    )
                  : SlidableAutoCloseBehavior(
                      closeWhenOpened: true,
                      child: Container(
                        child: SingleChildScrollView(
                          controller: cubit.scrollController,
                          child: Column(
                            children: [
                              AppLoadItemView(
                                  isGrid: false,
                                  items: List.generate(
                                      state.messages?.length ?? 0, (index) {
                                    return MessageView(
                                      onDissmis: (message) {
                                        cubit.forwerd(message);
                                      },
                                      edit: (message) {
                                        cubit.editMessage(message);
                                      },
                                      delete: (message) {
                                        cubit.deleteMessage(message);
                                      },
                                      messageModel: state.messages![index],
                                    );
                                  })),
                              const SizedBox(
                                height: 70,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              _sendMessage(context, state)
            ],
          ),
        ));
  }

  Widget _sendMessage(BuildContext context, ForumDetailState state) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (state.forumMessageModel != null)
            SlideAndOpasityAnimation(
                opasityDuration: 0,
                slideDuration: 200,
                child: _forwertView(state, context)),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 0),
            height: state.height,
            color: AppTheme.backColor(context),
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: TextField(
                    controller: cubit.message,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.newline,
                    cursorColor: AppTheme.oppositePrimaryColor(context),
                    style: TextStyle(
                        color: AppTheme.oppositePrimaryColor(context)),
                    decoration: InputDecoration(
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'message'.tr(),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: CustomButton.iconButton(
                        radius: 50,
                        onTab: () {
                          if (cubit.actionEdit.action) {
                            cubit.editMessage(null);
                          } else {
                            cubit.send();
                          }
                          FocusScope.of(context).unfocus();
                        },
                        child: Icon(
                          Icons.send_rounded,
                          size: 35,
                          color: AppColors.primaryColor1,
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _forwertView(ForumDetailState state, BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          color: AppTheme.backColor(context),
          child: Row(
            children: [
              Icon(
                Icons.forward,
                color: AppColors.primaryColor,
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              if (state.forumMessageModel?.user?.userPhoto != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: AppNetworkImage(
                    url: state.forumMessageModel?.user?.userPhoto,
                    wight: 30,
                    height: 30,
                  ),
                ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    state.forumMessageModel?.user?.name,
                    color: AppColors.primaryColor,
                    size: 14,
                  ),
                  AppText(
                    _logicText(state.forumMessageModel?.text),
                    color: AppTheme.grey1(context),
                    size: 12,
                  )
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  cubit.removeForwerd(context);
                },
                child: Icon(
                  Icons.clear,
                  color: AppTheme.oppositePrimaryColor(context),
                ),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: AppTheme.oppositePrimaryColor(context),
        ),
      ],
    );
  }

  String? _logicText(String? text) {
    if ((text?.length ?? 0) < 41) return text;
    return "${text?.substring(0, 40)} . . .";
  }
}
