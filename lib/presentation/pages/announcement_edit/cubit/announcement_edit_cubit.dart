import 'dart:convert';
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
part 'announcement_edit_state.dart';

class AnnouncemenEditCubit extends AppCubit<AnnouncementEditState> {
  AnnouncemenEditCubit() : super(AnnouncementEditState());
  StringBuffer deletedIds = StringBuffer("");

  String? id;
  Map? image;

  ProductDetailModel? productDetailModel;

  ImagePicker imagePicker = ImagePicker();

  final GlobalKey<FormState> formKey = GlobalKey();

  late TextEditingController price;

  late TextEditingController name;
  late TextEditingController address;
  late TextEditingController description;

  @override
  void init() {
    id = args.get["id"];
    image = args.get["image"];

    _loadData();
  }

  _loadData() async {
    emit(state.copyWith(state..isLoading = true));

    var response = await client.product(productId: id);

    double? _price;

    try {
      _price = double.parse(response.data?.first.price ?? "0");
    } catch (e) {
      _price = 0;
    }

    _setNetworkImages(response.data?.first.morePhotos);
    name = TextEditingController(text: response.data?.first.name);
    address = TextEditingController(text: response.data?.first.address);
    description = TextEditingController(text: response.data?.first.detailText);
    price = MoneyMaskedTextController(
        initialValue: _price,
        precision: 0,
        leftSymbol: "",
        decimalSeparator: "",
        thousandSeparator: " ",
        // ignore: prefer_interpolation_to_compose_strings
        rightSymbol: " " + "sum".tr());

    await _setCotegory(response.data?.first.sectionId);

    emit(state.copyWith(state..isLoading = false));
  }

  _setCotegory(String? id) async {
    var response = await client.subCategory(categoryId: id);

    emit(state.copyWith(state..cotegoryModel = response.data?.first));
  }

  _setNetworkImages(List<dynamic>? images) {
    List<Map> list = [];

    list = List.generate(images?.length ?? 0, (index) {
      return images![index];
    });

    list.add(image ?? {});

    emit(state.copyWith(state..networkimages = list));
  }

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

  deleteNetworkImage(int index) {
    List<Map> images = state.networkimages ?? [];

    deletedIds.write(",${images.removeAt(index)["id"]}");

    print(deletedIds);

    emit(state.copyWith(state..networkimages = images));
  }

  setCotegory(CotegoryModel? cotegoryModel) {
    emit(state.copyWith(state..cotegoryModel = cotegoryModel));
  }

  bool isValid() {
    List<AddAnnouncementErrors> erros = [];

    bool isValid = formKey.currentState?.validate() ?? false;

    bool cotegory = state.cotegoryModel == null;

    if (cotegory) {
      erros.add(AddAnnouncementErrors.cotegory);
    }

    emit(state.copyWith(state..addAnnouncementErrors = erros));

    return isValid && !cotegory;
  }

  addAnnouncement() async {
    if (isValid() == false) return;

    var formData = UploadFiles.getImagesOnData(state.images ?? []);

    loading.showLoading();

    String _price = price.text.replaceAll(" ", '');

    _price = _price.replaceAll("sum".tr(), "");

    var response = await client.addProduct(
        productId: id,
        morePhoto: formData,
        detailText: description.text,
        name: name.text,
        price: _price,
        action: "edit",
        subCategory: state.cotegoryModel?.categoryId,
        deletePhoto: (deletedIds.toString().replaceFirst(",", "")),
        address: address.text);

    await loading.hideLoading();

    AppToast _appToast = AppToast();

    _appToast.succesToast("your_announcement_succes_edited".tr());
  }

  _clearData() async {
    name.clear();
    address.clear();
    price.clear();
    description.clear();
    deletedIds.clear();
    emit(AnnouncementEditState());
  }

  deleteAnnoun() async {
    loading.showLoading();
    var response = await client.addProduct(
      productId: id,
      action: "delete",
    );
    loading.hideLoading();
    AppNavigator.back();
    AppNavigator.back();
  }

  @override
  void dispose() {
    _clearData();
  }
}
