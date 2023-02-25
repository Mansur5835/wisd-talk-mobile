import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:withtalk_mobile/core/utils/format_utils.dart';
import 'package:withtalk_mobile/presentation/components/animation/slide_and_opasity_animation.dart';
import 'package:withtalk_mobile/presentation/components/app_network_image.dart';
import 'package:withtalk_mobile/presentation/components/app_page.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/views/user_avatar.dart';
import 'package:withtalk_mobile/presentation/pages/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';

import '../../../data/constants/enums.dart';
import '../../components/app_bottom_sheet.dart';
import '../../components/app_text_field.dart';
import '../../components/buttons.dart';
import '../../components/views/image_option_view.dart';
import '../../components/views/slelect_lang_view.dart';
import '../../styles/app_colors.dart';

class EditProfilePage extends AppPage<EditProfileCubit, EditProfileState> {
  static const String route = "/edit_profile_page";
  EditProfilePage({super.key});

  @override
  Widget build(BuildContext context, state) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor(context),
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor(context),
        elevation: 0,
        title: AppText(
          "edit_profile".tr(),
          fontWeight: FontWeight.w500,
          color: AppTheme.oppositePrimaryColor(context),
        ),
        leading: GestureDetector(
          onTap: () {
            AppNavigator.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: AppTheme.oppositePrimaryColor(context),
          ),
        ),
      ),
      body: Form(
        key: cubit.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _profileImage(state),
              const SizedBox(
                height: 10,
              ),
              SlideAndOpasityAnimation(
                opasityDuration: 0,
                slideDuration: 500,
                child: _name(),
              ),
              SlideAndOpasityAnimation(
                  opasityDuration: 0,
                  slideDuration: 600,
                  child: _phone(state, context)),
              SlideAndOpasityAnimation(
                opasityDuration: 0,
                slideDuration: 700,
                child: _email(),
              ),
              SlideAndOpasityAnimation(
                opasityDuration: 0,
                slideDuration: 800,
                child: _city(),
              ),
              SlideAndOpasityAnimation(
                  opasityDuration: 0,
                  slideDuration: 900,
                  child: _dateOfBirthDay()),
              SlideAndOpasityAnimation(
                opasityDuration: 0,
                slideDuration: 1000,
                child: _button(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _city() {
    return AppTextField(
      controller: cubit.city,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      radius: 10,
      label: "city".tr(),
      color: AppColors.primaryColor01,
    );
  }

  Widget _dateOfBirthDay() {
    return AppTextField(
      controller: cubit.date,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      radius: 10,
      label: "dd.mm.yyyy".tr(),
      color: AppColors.primaryColor01,
    );
  }

  Widget _phone(EditProfileState state, BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              AppBottomSheet(
                      withTitle: false,
                      child: SelctLangView(
                        onTap: (selectedLang) {
                          cubit.setCountry(selectedLang);
                        },
                      ),
                      height: 200)
                  .show();
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  state.countiryImage ?? "flag_en",
                  width: 55,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
            )),
        Expanded(
          child: AppTextField(
            controller: cubit.phone,
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 20),
            radius: 10,
            label: state.code ?? "+1",
            inputFormatters: [
              PhoneNumberTextInputFormatter(),
              FilteringTextInputFormatter.digitsOnly
            ],
            color: AppColors.primaryColor01,
          ),
        ),
      ],
    );
  }

  Widget _button() {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 50,
      child: PrimaryButton(
        borderRadius: 10,
        onTap: () {
          cubit.editProfile();
        },
        backGroundColor: AppColors.primaryColor,
        title: "save_changs".tr(),
      ),
    );
  }

  Widget _profileImage(EditProfileState state) {
    return Stack(
      children: [
        if (state.image == null) ...{
          cubit.user?.photo == null
              ? Hero(
                  tag: "profile_image",
                  child: UserAvatar(
                    size: 100,
                  ),
                )
              : Hero(
                  tag: "profile_image",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3232),
                    child: AppNetworkImage(
                      url: cubit.user?.photo,
                      wight: 100,
                      height: 100,
                    ),
                  ),
                ),
        } else ...{
          ClipRRect(
            borderRadius: BorderRadius.circular(2123),
            child: Image.file(
              state.image!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        },
        Container(
            padding: const EdgeInsets.only(bottom: 15),
            width: 100,
            height: 100,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2134234),
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.primaryBlack,
                      Colors.transparent,
                      Colors.transparent,
                    ])),
            child: GestureDetector(
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
              child: AppText(
                "edit".tr(),
                color: AppColors.white,
              ),
            )),
      ],
    );
  }

  Widget _name() {
    return AppTextField(
      controller: cubit.name,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      radius: 10,
      label: "full_name".tr(),
      color: AppColors.primaryColor01,
      validator: (name) {
        if ((name?.length ?? 0) < 3) {
          return "name_error".tr();
        }
      },
    );
  }

  Widget _email() {
    return AppTextField(
      controller: cubit.email,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      radius: 10,
      label: "email".tr(),
      color: AppColors.primaryColor01,
      validator: (value) {
        final bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value ?? "");

        if (!emailValid) {
          return "email_error".tr();
        }
      },
    );
  }
}
