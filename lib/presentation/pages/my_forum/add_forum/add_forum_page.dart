import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:withtalk_mobile/data/constants/enums.dart';
import 'package:withtalk_mobile/data/models/forum.dart';
import 'package:withtalk_mobile/presentation/components/animation/slide_and_opasity_animation.dart';
import 'package:withtalk_mobile/presentation/components/buttons.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_widget.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';

import '../../../../data/models/cotegory.dart';
import '../../../components/app_select_cotegory.dart';
import '../../../components/app_text.dart';
import '../../../components/app_text_field.dart';
import '../../../routes/app_navigator.dart';
import '../../../styles/app_colors.dart';
import 'cubit/add_forum_cubit.dart';

class AddForumPage extends StatefulWidget {
  final ForumModel? forumModel;
  const AddForumPage({super.key, this.forumModel});

  @override
  State<AddForumPage> createState() => _AddForumPageState();
}

class _AddForumPageState extends State<AddForumPage> {
  late AddForumCubit cubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddForumCubit()..init(widget.forumModel),
      child: BlocBuilder<AddForumCubit, AddForumState>(
        builder: (context, state) {
          cubit = BlocProvider.of<AddForumCubit>(context);
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
                "add_forum".tr(),
                fontWeight: FontWeight.bold,
                color: AppTheme.oppositePrimaryColor(context),
              ),
            ),
            body: state.isLoading
                ? const Center(
                    child: LoadingViewWidget(
                      radius: 50,
                    ),
                  )
                : Form(
                    key: cubit.formKey,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SlideAndOpasityAnimation(
                                opasityDuration: 0,
                                slideDuration: 500,
                                child: _name(context)),
                            const SizedBox(
                              height: 20,
                            ),
                            SlideAndOpasityAnimation(
                                opasityDuration: 0,
                                slideDuration: 600,
                                child: _cotegory(context, state)),
                            const SizedBox(
                              height: 20,
                            ),
                            SlideAndOpasityAnimation(
                                opasityDuration: 0,
                                slideDuration: 700,
                                child: _descreition(context)),
                            const SizedBox(
                              height: 20,
                            ),
                            SlideAndOpasityAnimation(
                                opasityDuration: 0,
                                slideDuration: 800,
                                child: _buttons())
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buttons() {
    return Container(
      child: Column(
        children: [
          if (cubit.forumModel != null)
            AppOutlinedButton(
              onTap: () {
                cubit.deleteForum();
              },
              borderRadius: 10,
              size: const Size(double.infinity, 50),
              color: AppColors.primaryColor,
              label: "delete_forum".tr(),
            ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: PrimaryButton(
              onTap: () {
                cubit.addForum();
              },
              borderRadius: 10,
              title: !cubit.chackEditOrAdd()
                  ? "save_changs".tr()
                  : "add_forum".tr(),
              backGroundColor: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _descreition(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: AppText(
            "description".tr(),
            color: AppTheme.oppositePrimaryColor(context),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        AppTextField(
          maxLines: 8,
          validator: (value) {
            if ((value?.length ?? 0) < 4) {
              return "required".tr();
            }
          },
          controller: cubit.description,
          textCapitalization: TextCapitalization.sentences,
          label: "required".tr(),
          textInputType: TextInputType.multiline,
          margin: EdgeInsets.zero,
          radius: 10,
          color: AppColors.primaryColor01,
        ),
      ],
    );
  }

  Widget _name(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: AppText(
            "add_name".tr(),
            color: AppTheme.oppositePrimaryColor(context),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        AppTextField(
          controller: cubit.name,
          label: "required".tr(),
          margin: EdgeInsets.zero,
          radius: 10,
          validator: (value) {
            if ((value?.length ?? 0) < 4) {
              return "required".tr();
            }
          },
          color: AppColors.primaryColor01,
        ),
      ],
    );
  }

  Widget _cotegory(BuildContext context, AddForumState state) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: AppText(
            "select_cotegory".tr(),
            color: AppTheme.oppositePrimaryColor(context),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () async {
            CotegoryModel? cotegory = await AppNavigator.toNamed(
                AppSelectCotegoryView.route,
                arguments: true);

            if (cotegory == null) return;
            cubit.setCotegory(cotegory);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    border: (state.addForumErrors
                                ?.contains(AddForumErrors.cotegory) ??
                            false)
                        ? Border.all(width: 1, color: AppColors.red)
                        : null,
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryColor01),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    AppText(
                      state.cotegoryModel?.name ?? "required".tr(),
                      color: state.cotegoryModel != null
                          ? AppTheme.oppositePrimaryColor(context)
                          : AppColors.grey,
                    ),
                    const Spacer(),
                    state.cotegoryModel == null
                        ? Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColors.grey,
                          )
                        : GestureDetector(
                            onTap: () {
                              cubit.emit(
                                  state.copyWith(state..cotegoryModel = null));
                            },
                            child: Icon(
                              Icons.clear,
                              color: AppTheme.oppositePrimaryColor(context),
                            ),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              if ((state.addForumErrors?.contains(AddForumErrors.cotegory) ??
                  false))
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.all(5),
                  child: AppText(
                    "required".tr(),
                    color: AppColors.red,
                    fontWeight: FontWeight.w300,
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
