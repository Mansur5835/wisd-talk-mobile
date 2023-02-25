import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:withtalk_mobile/core/utils/bloc_logic.dart';
import 'package:withtalk_mobile/data/local_sources/local_storage.dart';
import 'package:withtalk_mobile/data/models/user.dart';
import 'package:withtalk_mobile/presentation/components/app_toast.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';
import 'package:withtalk_mobile/presentation/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../data/constants/enums.dart';
import '../../../components/app_cubit.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends AppCubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileState());

  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController city;
  late TextEditingController date;
  late MaskedTextController phone;

  GlobalKey<FormState> formKey = GlobalKey();
  ImagePicker imagePicker = ImagePicker();

  User? user;

  @override
  void init() {
    user = args.get;
    phone = MaskedTextController(
      mask: "+998 (00) 000 00 00",
      text: user?.phone,
    )..mask = mask();

    name = TextEditingController(text: user?.name);

    email = TextEditingController(text: user?.email);

    city = TextEditingController(text: user?.city);

    date = MaskedTextController(mask: "00.00.0000", text: user?.birthday);
  }

  String mask() {
    LocalStorage localStorage = LocalStorage();

    String? code = localStorage.readData(BoxKeys.LANG_CODE);

    if (code == "en") {
      setLangAndMask(AssetsManager.images(
        name: "flag_en",
      ));

      return "+1 (000) 000 00 00";
    }

    if (code == "ko") {
      setLangAndMask(AssetsManager.images(
        name: "flag_ko",
      ));

      return "+82 (00) 0000 0000";
    }
    setLangAndMask(AssetsManager.images(name: "flag_uz", format: "jpeg"));

    return "+998 (00) 000 00 00";
  }

  setLangAndMask(String image, [String? _code]) {
    emit(state.copyWith(state
      ..countiryImage = image
      ..code = _code ?? code()));
  }

  String code() {
    LocalStorage localStorage = LocalStorage();

    String? code = localStorage.readData(BoxKeys.LANG_CODE);

    if (code == "en") {
      return "+1";
    }

    if (code == "ko") {
      return "+82";
    }

    return "+998";
  }

  setCountry(SelectedLang selectedLang) {
    AppNavigator.back();
    if (selectedLang == SelectedLang.KO) {
      phone.mask = "+82 (00) 0000 0000";
      setLangAndMask(AssetsManager.images(name: "flag_ko"), "+82");
    } else if (selectedLang == SelectedLang.EN) {
      setLangAndMask(AssetsManager.images(name: "flag_en"), "+1");
      phone.mask = "+1 (000) 000 00 00";
    } else {
      phone.mask = "+998 (00) 000 00 00";
      setLangAndMask(
          AssetsManager.images(name: "flag_uz", format: "jpeg"), "+998");
    }
  }

  setImages(ImageOption imageOption) async {
    var image = await imagePicker.pickImage(
        source: imageOption == ImageOption.camera
            ? ImageSource.camera
            : ImageSource.gallery);
    AppNavigator.back();

    if (image == null) return;

    emit(state.copyWith(state..image = File(image.path)));
  }

  editProfile() async {
    bool isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    loading.showLoading();

    var response = await client.editProfile(
        action: "edit",
        login: email.text,
        name: name.text,
        personalPhoto: state.image,
        phone: phone.text,
        email: email.text,
        birthday: date.text,
        city: city.text);

    final dashCubit = BlocLogic<DashboardCubit>()();

    await dashCubit.loadUserDataAgain();

    await loading.hideLoading();

    AppToast appToast = AppToast();

    appToast.succesToast("profile_has_succes_changed".tr());
  }

  @override
  void dispose() {
    emit(EditProfileState());
  }
}
