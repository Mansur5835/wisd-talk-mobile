import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:withtalk_mobile/data/models/cotegory.dart';
import 'package:withtalk_mobile/data/models/sort_model.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/app_text_field.dart';
import 'package:withtalk_mobile/presentation/components/buttons.dart';
import 'package:withtalk_mobile/presentation/components/views/cotegory_view.dart';
import 'package:withtalk_mobile/presentation/pages/cotegory/cotegory_page.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_colors.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';

import '../app_select_cotegory.dart';
import '../app_select_item.dart';

class ProductSortView extends StatefulWidget {
  const ProductSortView({super.key});

  @override
  State<ProductSortView> createState() => _ProdyctSortViewState();
}

class _ProdyctSortViewState extends State<ProductSortView> {
  int _index = 10;

  List<String> sortTexts = ["price_min", "price_max", "new"];

  CotegoryModel? cotegoryModel;

  SortModel sortModel = SortModel();

  final TextEditingController from = MoneyMaskedTextController(
      initialValue: 0,
      precision: 0,
      leftSymbol: "",
      decimalSeparator: "",
      thousandSeparator: " ",
      // ignore: prefer_interpolation_to_compose_strings
      rightSymbol: " " + "sum".tr());

  final TextEditingController to = MoneyMaskedTextController(
      initialValue: 0,
      precision: 0,
      leftSymbol: "",
      decimalSeparator: "",
      thousandSeparator: " ",
      // ignore: prefer_interpolation_to_compose_strings
      rightSymbol: " " + "sum".tr());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      alignment: Alignment.center,
      child: Column(
        children: [
          _sort(),
          const SizedBox(
            height: 20,
          ),
          _cotegory(),
          const SizedBox(
            height: 20,
          ),
          _price(),
          const SizedBox(
            height: 20,
          ),
          _buttons()
        ],
      ),
    );
  }

  Widget _buttons() {
    return Column(
      children: [
        AppOutlinedButton(
            onTap: () {
              AppNavigator.back();
            },
            size: const Size(double.infinity, 50),
            label: "cancel".tr(),
            color: AppColors.primaryColor),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: PrimaryButton(
            onTap: () {
              String? _to = to.text.replaceAll("sum".tr(), "");
              String? _from = from.text.replaceAll("sum".tr(), "");

              sortModel.to = _to.replaceAll(" ", "");
              sortModel.from = _from.replaceAll(" ", "");
              sortModel.cotegory = cotegoryModel;
              sortModel.sort = sortTexts[_index];
              AppNavigator.back(result: sortModel);
            },
            title: "confirm".tr(),
            backGroundColor: AppColors.primaryColor,
          ),
        )
      ],
    );
  }

  Widget _sort() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: AppText(
            "sort".tr(),
            color: AppTheme.oppositePrimaryColor(context),
            fontWeight: FontWeight.bold,
            size: 18,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 40,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(sortTexts.length, (index) {
                return AppSelectItem(
                  isSelecded: index == _index,
                  title: sortTexts[index].tr(),
                  onTap: () {
                    setState(() {
                      _index = index;
                    });
                  },
                );
              }),
            ),
          ),
        )
      ],
    );
  }

  Widget _price() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: AppText(
            "${"price".tr()} (${"sum".tr()})",
            color: AppTheme.oppositePrimaryColor(context),
            fontWeight: FontWeight.bold,
            size: 18,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child: Column(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: AppText(
                      "from".tr(),
                      size: 16,
                      color: AppTheme.oppositePrimaryColor(context),
                    )),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  controller: from,
                  margin: EdgeInsets.zero,
                  textInputType: TextInputType.number,
                  label: "from".tr(),
                  color: AppColors.primaryColor01,
                )
              ],
            )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: AppText(
                      "to".tr(),
                      size: 16,
                      color: AppTheme.oppositePrimaryColor(context),
                    )),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  controller: to,
                  margin: EdgeInsets.zero,
                  label: "to".tr(),
                  textInputType: TextInputType.number,
                  color: AppColors.primaryColor01,
                )
              ],
            )),
          ],
        ),
      ],
    );
  }

  Widget _cotegory() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: AppText(
            "cotegories".tr(),
            color: AppTheme.oppositePrimaryColor(context),
            fontWeight: FontWeight.bold,
            size: 18,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () async {
            CotegoryModel? cotegory =
                await AppNavigator.toNamed(AppSelectCotegoryView.route);

            if (cotegory == null) return;

            setState(() {
              cotegoryModel = cotegory;
            });
          },
          child: Container(
            height: 50,
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.primaryColor01,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                AppText(
                  cotegoryModel == null ? "select".tr() : cotegoryModel?.name,
                  color: AppTheme.oppositePrimaryColor(context),
                ),
                const Spacer(),
                if (cotegoryModel != null)
                  CustomButton.iconButton(
                      onTab: () {
                        setState(() {
                          cotegoryModel = null;
                        });
                      },
                      radius: 30,
                      child: Icon(
                        Icons.clear,
                        color: AppTheme.oppositePrimaryColor(context),
                      ))
                else ...{
                  Icon(
                    Icons.chevron_right_rounded,
                    color: AppTheme.oppositePrimaryColor(context),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                }
              ],
            ),
          ),
        ),
      ],
    );
  }
}
