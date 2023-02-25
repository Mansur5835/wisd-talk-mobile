import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:withtalk_mobile/core/utils/screen_size.dart';
import 'package:withtalk_mobile/data/constants/enums.dart';
import 'package:withtalk_mobile/data/models/sort_model.dart';
import 'package:withtalk_mobile/presentation/components/app_bottom_sheet.dart';
import 'package:withtalk_mobile/presentation/components/app_page.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/app_text_field.dart';
import 'package:withtalk_mobile/presentation/components/buttons.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_widget.dart';
import 'package:withtalk_mobile/presentation/pages/search/cubit/search_cubit.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_colors.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';

import '../../../core/utils/assets_manager.dart';
import '../../components/app_load_item_widget.dart';
import '../../components/views/product_item_view.dart';
import '../../components/views/product_sort_view.dart';

class SearchPage extends AppPage<SearchCubit, SearchState> {
  static const String route = "/search_page";
  SearchPage({super.key});
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context, state) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor(context),
      body: SafeArea(
        child: Stack(
          children: [_foundCases(state, context), _serachBar(context)],
        ),
      ),
    );
  }

  Widget _foundCases(SearchState state, BuildContext context) {
    switch (state.serachCases) {
      case SearchCase.searching:
        return Container(
          width: ScreenSize.size().width,
          height: ScreenSize.size().height,
          alignment: Alignment.center,
          child: const LoadingViewWidget(
            radius: 45,
          ),
        );
      case SearchCase.found:
        return Container(
          margin: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 15, left: 15, right: 15, bottom: 20),
                child: Row(
                  children: [
                    AppText(
                      "${state.foundProducts} ${"found_result".tr()}",
                      size: 18,
                      color: AppTheme.oppositePrimaryColor(context),
                    ),
                    const Spacer(),
                    CustomButton.iconButton(
                      onTab: () async {
                        SortModel? sortmodel = await AppBottomSheet(
                                child: const ProductSortView(),
                                title: "sort_and_filter".tr(),
                                height: ScreenSize.size().height - 100)
                            .show();
                        cubit.sort(sortmodel);
                      },
                      child: Icon(
                        Icons.sort_sharp,
                        color: AppTheme.oppositePrimaryColor(context),
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: AppLoadItemView(
                            parentScrollController: scrollController,
                            loadMore: () async {
                              await cubit.loadMore();
                            },
                            items: List.generate(state.products?.length ?? 0,
                                (index) {
                              return ProductItemView(
                                productModel: state.products![index],
                              );
                            })),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      case SearchCase.notFount:
        return Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(AssetsManager.lottie(name: "empty"),
                  width: 200, height: 200, fit: BoxFit.cover),
              AppText(
                "${state.foundProducts} ${"found_result".tr()}",
                size: 18,
                color: AppTheme.oppositePrimaryColor(context),
              ),
            ],
          ),
        );
      case SearchCase.none:
        return Container();
    }
  }

  Widget _serachBar(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        child: AppTextField(
          radius: 10,
          autofocus: true,
          prefixIcon: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            child: Hero(
              tag: "search",
              child: Image.asset(
                AssetsManager.icon(name: "search"),
                width: 30,
                height: 30,
                fit: BoxFit.cover,
                color: AppTheme.textColor(context),
              ),
            ),
          ),
          margin: EdgeInsets.zero,
          icon: Icons.close,
          iconTab: () {
            AppNavigator.back();
          },
          label: "search".tr(),
          onSubmitted: (text) {
            cubit.search(text);
          },
          textInputAction: TextInputAction.search,
          color: AppColors.primaryColor01,
        ),
      ),
    );
  }
}
