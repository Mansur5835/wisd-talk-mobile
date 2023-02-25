import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:withtalk_mobile/presentation/components/app_load_item_widget.dart';
import 'package:withtalk_mobile/presentation/components/app_page.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_widget.dart';
import 'package:withtalk_mobile/presentation/pages/favatires/cubit/favorites_cubit.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';
import '../../components/views/product_item_view.dart';

// ignore: must_be_immutable
class FavoritePage extends AppPage<FavoritesCubit, FavoritesState> {
  FavoritePage({super.key});

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context, state) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor(context),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.primaryColor(context),
        title: AppText(
          "favorites".tr(),
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
          : SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: AppLoadItemView(
                        parentScrollController: scrollController,
                        loadMore: cubit.loadMore,
                        items:
                            List.generate(state.products?.length ?? 0, (index) {
                          return ProductItemView(
                            likeTaped: () {
                              cubit.loadData();
                            },
                            productModel: state.products![index],
                          );
                        })),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
    );
  }
}
