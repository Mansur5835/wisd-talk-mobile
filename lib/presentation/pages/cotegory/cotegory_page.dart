import 'package:flutter/material.dart';
import 'package:withtalk_mobile/data/local_sources/local_storage.dart';
import 'package:withtalk_mobile/presentation/components/app_load_item_widget.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/buttons.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_widget.dart';
import 'package:withtalk_mobile/presentation/pages/cotegory/cubit/cotegory_cubit.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';
import '../../components/app_page.dart';
import '../../components/views/product_item_view.dart';

class CotegoryPage extends AppPage<CotegoryCubit, CotegoryState> {
  static const String route = "/cotegory_page";

  CotegoryPage({super.key});

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context, state) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor(context),
      appBar: AppBar(
        elevation: 0,
        title: AppText(
          state.name,
          color: AppTheme.oppositePrimaryColor(context),
          fontWeight: FontWeight.w600,
        ),
        leading: CustomButton.iconButton(
            onTab: () {
              AppNavigator.back();
            },
            child: Icon(
              Icons.arrow_back_outlined,
              color: AppTheme.oppositePrimaryColor(context),
            )),
        backgroundColor: AppTheme.primaryColor(context),
      ),
      body: !state.isLoading
          ? SingleChildScrollView(
              controller: scrollController,
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    AppLoadItemView(
                        parentScrollController: scrollController,
                        loadMore: cubit.loadMore,
                        items:
                            List.generate(state.products?.length ?? 0, (index) {
                          return ProductItemView(
                            productModel: state.products![index],
                          );
                        })),
                  ],
                ),
              ),
            )
          : const Center(
              child: LoadingViewWidget(
                radius: 50,
              ),
            ),
    );
  }
}
