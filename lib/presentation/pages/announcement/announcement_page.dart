import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:withtalk_mobile/core/utils/assets_manager.dart';
import 'package:withtalk_mobile/data/constants/enums.dart';
import 'package:withtalk_mobile/data/models/cotegory.dart';
import 'package:withtalk_mobile/main.dart';
import 'package:withtalk_mobile/presentation/components/animation/slide_and_opasity_animation.dart';
import 'package:withtalk_mobile/presentation/components/app_bottom_sheet.dart';
import 'package:withtalk_mobile/presentation/components/app_dialog.dart';
import 'package:withtalk_mobile/presentation/components/app_page.dart';
import 'package:withtalk_mobile/presentation/components/app_select_cotegory.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/app_text_field.dart';
import 'package:withtalk_mobile/presentation/components/buttons.dart';
import 'package:withtalk_mobile/presentation/pages/announcement/cubit/announcement_cubit.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';
import '../../components/views/has_not_user_action_view,.dart';
import '../../components/views/image_option_view.dart';
import '../../styles/app_colors.dart';

class AnnouncementPage extends AppPage<AnnouncementCubit, AnnouncementState> {
  AnnouncementPage({super.key});

  @override
  Widget build(BuildContext context, state) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor(context),
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor(context),
        elevation: 0,
        title: AppText(
          "add_announcement".tr(),
          color: AppTheme.oppositePrimaryColor(context),
        ),
      ),
      body: Form(
        key: cubit.formKey,
        child: Container(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
              child: Column(
            children: [
              SlideAndOpasityAnimation(
                  opasityDuration: 100,
                  slideDuration: 500,
                  child: _images(context, state)),
              SlideAndOpasityAnimation(
                  opasityDuration: 100,
                  slideDuration: 600,
                  child: _name(context)),
              const SizedBox(
                height: 20,
              ),
              SlideAndOpasityAnimation(
                  opasityDuration: 100,
                  slideDuration: 700,
                  child: _cotegory(context, state)),
              const SizedBox(
                height: 20,
              ),
              SlideAndOpasityAnimation(
                  opasityDuration: 100,
                  slideDuration: 800,
                  child: _price(context)),
              const SizedBox(
                height: 20,
              ),
              SlideAndOpasityAnimation(
                  opasityDuration: 100,
                  slideDuration: 900,
                  child: _addres(context)),
              const SizedBox(
                height: 20,
              ),
              SlideAndOpasityAnimation(
                  opasityDuration: 100,
                  slideDuration: 1000,
                  child: _descreition(context)),
              const SizedBox(
                height: 20,
              ),
              SlideAndOpasityAnimation(
                  opasityDuration: 100, slideDuration: 1100, child: _button()),
              const SizedBox(
                height: 80,
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget _button() {
    return Container(
      height: 50,
      child: PrimaryButton(
        onTap: () {
          if (!hasUser) {
            const AppDialog(
              child: HasNotUserAvtionView(),
            ).show();
            return;
          }
          cubit.addAnnouncement();
        },
        backGroundColor: AppColors.primaryColor,
        title: "add_announcement_1".tr(),
      ),
    );
  }

  Widget _addres(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: AppText(
            "address".tr(),
            color: AppTheme.oppositePrimaryColor(context),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        AppTextField(
          validator: (value) {
            if ((value?.length ?? 0) < 4) {
              return "required".tr();
            }
          },
          controller: cubit.address,
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

  Widget _cotegory(BuildContext context, AnnouncementState state) {
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
            );
            cubit.setCotegory(cotegory);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    border: (state.addAnnouncementErrors
                                ?.contains(AddAnnouncementErrors.cotegory) ??
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
              if ((state.addAnnouncementErrors
                      ?.contains(AddAnnouncementErrors.cotegory) ??
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

  Widget _images(BuildContext context, AnnouncementState state) {
    bool hasData = state.images == null;

    hasData = hasData ? true : state.images!.isEmpty;

    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: AppText(
              "add_images".tr(),
              color: AppTheme.oppositePrimaryColor(context),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          hasData
              ? GestureDetector(
                  onTap: () {
                    AppBottomSheet(
                            child: ImageOptionView(
                              camera: () {
                                cubit.setImages(ImageOption.camera);
                              },
                              gellary: () {
                                cubit.setImages(ImageOption.gellary);
                              },
                            ),
                            height: 200,
                            title: "image_option".tr())
                        .show();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AssetsManager.icon(
                            name: "add_none",
                          ),
                          height: 50,
                          cacheHeight: 50,
                          color: (state.addAnnouncementErrors
                                      ?.contains(AddAnnouncementErrors.image) ??
                                  false)
                              ? AppColors.red
                              : AppColors.primaryColor,
                        ),
                        if ((state.addAnnouncementErrors
                                ?.contains(AddAnnouncementErrors.image) ??
                            false))
                          AppText(
                            "required".tr(),
                            color: AppColors.red,
                          )
                      ],
                    ),
                  ),
                )
              : Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(state.images?.length ?? 0, (index) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            child: Stack(
                              children: [
                                Image.file(
                                  state.images![index],
                                  width: 200,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  alignment: Alignment.topRight,
                                  width: 200,
                                  child: GestureDetector(
                                    onTap: () {
                                      cubit.deleteImage(index);
                                    },
                                    child: Icon(
                                      Icons.highlight_remove,
                                      color: AppColors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                        GestureDetector(
                          onTap: () {
                            AppBottomSheet(
                                    child: ImageOptionView(
                                      camera: () {
                                        cubit.setImages(ImageOption.camera);
                                      },
                                      gellary: () {
                                        cubit.setImages(ImageOption.gellary);
                                      },
                                    ),
                                    height: 200,
                                    title: "image_option".tr())
                                .show();
                          },
                          child: Image.asset(
                            AssetsManager.icon(
                              name: "add_none",
                            ),
                            height: 50,
                            cacheHeight: 50,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
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

  Widget _price(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: AppText(
            "price".tr(),
            color: AppTheme.oppositePrimaryColor(context),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        AppTextField(
          validator: (value) {
            String? _price = value?.replaceAll(" ", '');

            _price = _price?.replaceAll("sum".tr(), "");
            if ((_price?.length ?? 0) < 4) {
              return "required".tr();
            }
          },
          controller: cubit.price,
          label: "required".tr(),
          textInputType: TextInputType.number,
          margin: EdgeInsets.zero,
          radius: 10,
          color: AppColors.primaryColor01,
        ),
      ],
    );
  }
}
