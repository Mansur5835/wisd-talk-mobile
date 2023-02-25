import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:withtalk_mobile/core/utils/upload_files.dart';
import 'package:withtalk_mobile/data/models/cotegory.dart';
import 'package:withtalk_mobile/data/models/product_detail.dart';
import 'package:withtalk_mobile/presentation/components/app_toast.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';
import '../../../../data/constants/enums.dart';
import '../../../components/app_cubit.dart';
import '../../../routes/app_navigator.dart';
part 'announcement_state.dart';

class AnnouncementCubit extends AppCubit<AnnouncementState> {
  AnnouncementCubit() : super(AnnouncementState());

  ProductDetailModel? productDetailModel;

  ImagePicker imagePicker = ImagePicker();

  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController price = MoneyMaskedTextController(
      initialValue: 0,
      precision: 0,
      leftSymbol: "",
      decimalSeparator: "",
      thousandSeparator: " ",
      // ignore: prefer_interpolation_to_compose_strings
      rightSymbol: " " + "sum".tr());

  final TextEditingController name = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  void init() {}

  setImages(ImageOption imageOption) async {
    List<XFile> _images = [];

    if (imageOption == ImageOption.camera) {
      var image = await imagePicker.pickImage(source: ImageSource.camera);
      if (image == null) return;

      _images.add(image);
    } else {
      _images = await imagePicker.pickMultiImage();
    }

    List<File> images = state.images ?? [];

    images.addAll(List.generate(_images.length, (index) {
      return File(_images[index].path);
    }));

    AppNavigator.back();
    emit(state.copyWith(state..images = images));
  }

  deleteImage(int index) {
    List<File> images = state.images ?? [];

    images.removeAt(index);

    emit(state.copyWith(state..images = images));
  }

  setCotegory(CotegoryModel? cotegoryModel) {
    emit(state.copyWith(state..cotegoryModel = cotegoryModel));
  }

  bool isValid() {
    List<AddAnnouncementErrors> erros = [];

    bool isValid = formKey.currentState?.validate() ?? false;

    bool cotegory = state.cotegoryModel == null;

    bool image = state.images == null || (state.images?.isEmpty ?? true);

    if (cotegory) {
      erros.add(AddAnnouncementErrors.cotegory);
    }

    if (image) {
      erros.add(AddAnnouncementErrors.image);
    }

    emit(state.copyWith(state..addAnnouncementErrors = erros));

    return isValid && !image && !cotegory;
  }

  addAnnouncement() async {
    if (isValid() == false) return;

    var formData = UploadFiles.getImagesOnData(state.images ?? []);

    loading.showLoading();

    String _price = price.text.replaceAll(" ", '');

    _price = _price.replaceAll("sum".tr(), "");

    var response = await client.addProduct(
        morePhoto: formData,
        detailText: description.text,
        name: name.text,
        price: _price,
        action: "add",
        subCategory: state.cotegoryModel?.categoryId,
        address: address.text);

    await loading.hideLoading();
    _clearData();

    AppToast _appToast = AppToast();

    _appToast.succesToast("your_announcement_succes_added".tr());
  }

  _clearData() async {
    name.clear();
    address.clear();
    price.clear();
    description.clear();
    emit(AnnouncementState());
  }

  @override
  void dispose() {
    emit(AnnouncementState());
  }
}
