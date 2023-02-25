import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:withtalk_mobile/core/utils/assets_manager.dart';
import 'package:withtalk_mobile/presentation/components/animation/slide_and_opasity_animation.dart';
import 'package:withtalk_mobile/presentation/components/animation/twen_anim.dart';
import 'package:withtalk_mobile/presentation/components/app_page.dart';
import 'package:withtalk_mobile/presentation/components/app_select_item.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/app_load_item_widget.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_widget.dart';
import 'package:withtalk_mobile/presentation/components/views/forum_ui.dart';
import 'package:withtalk_mobile/presentation/pages/main/cubit/main_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/search/search_page.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';
import '../../components/views/cotegory_view.dart';
import '../../components/views/product_item_view.dart';
import '../../styles/app_colors.dart';

class MainPage extends AppPage<MainCubit, MainState> {
  MainPage({super.key});

  @override
  Widget build(BuildContext context, state) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor(context),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: cubit.scrollController,
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  _forums(context, state),
                  const SizedBox(
                    height: 20,
                  ),
                  _cotegories(state, context),
                  _products(state, context),
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
            _searchBar(state, context),
          ],
        ),
      ),
    );
  }

  Widget _forums(BuildContext context, MainState state) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,
          child: AppText(
            "forums".tr(),
            fontWeight: FontWeight.bold,
            color: AppTheme.oppositePrimaryColor(context),
            size: 16,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          height: 45,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(width: 2, color: AppTheme.backColor(context))),
              child: Row(
                children: List.generate(state.forums?.length ?? 0, (index) {
                  return AppSelectItem(
                      withBorder: false,
                      isSelecded: index == state.indexForum,
                      onTap: () {
                        cubit.forumIndexTap(index);
                      },
                      title: state.forums![index].name ?? "");
                }),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          height: state.height,
          child: PageView(
            controller: cubit.pageController,
            onPageChanged: (index) {
              cubit.pageChanging(index);
            },
            children: List.generate(state.forums?.length ?? 0, (index) {
              return SingleChildScrollView(
                child: ForumUI(
                  id: state.forums?[index].categoryId,
                  bulder: (count, isLoading) {
                    cubit.logicHaight(count, isLoading);
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _products(MainState state, BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,
          child: AppText(
            "top_announcements".tr(),
            fontWeight: FontWeight.bold,
            color: AppTheme.oppositePrimaryColor(context),
            size: 16,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (state.isLoading)
          Container(
            width: double.infinity,
            height: 200,
            alignment: Alignment.center,
            child: const LoadingViewWidget(
              radius: 50,
            ),
          )
        else
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: AppLoadItemView(
                parentScrollController: cubit.scrollController,
                loadMore: cubit.loadMore,
                items: List.generate(state.products?.length ?? 0, (index) {
                  return ProductItemView(
                    scrollDirection: state.scrollDirection,
                    productModel: state.products![index],
                  );
                })),
          ),
      ],
    );
  }

  Widget _cotegories(MainState state, BuildContext context) {
    return SizedBox(
      height: 195,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.centerLeft,
            child: AppText(
              "cotegories".tr(),
              fontWeight: FontWeight.bold,
              color: AppTheme.oppositePrimaryColor(context),
              size: 16,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 160,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                      List.generate(state.cotegoties?.length ?? 0, (index) {
                    return SlideAndOpasityAnimation(
                      slideBegin: const Offset(4, 0),
                      opasityDuration: 80,
                      slideDuration: ((index + 1)) * 150,
                      child: CotegoryView(
                        cotegoryModel: state.cotegoties![index],
                      ),
                    );
                  })),
            ),
          )
        ],
      ),
    );
  }

  Widget _searchBar(MainState state, BuildContext context) {
    return TweenAnim<double>(
      duration: 500,
      end: state.hideSearchBar ? -1.3 : -1,
      begin: -1,
      child: (value) => Container(
        alignment: Alignment(0, value),
        child: TweenAnim<double>(
          begin: 0,
          end: state.hideSearchBar ? 0 : 500,
          duration: 500,
          child: (value) => GestureDetector(
            onTap: () {
              AppNavigator.toNamed(SearchPage.route);
            },
            child: Container(
              height: 50,
              width: value,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  color: AppTheme.backColor(context),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Hero(
                    tag: "search",
                    child: Image.asset(
                      AssetsManager.icon(name: "search"),
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                      color: AppTheme.textColor(context),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  AppText(
                    "search".tr(),
                    color: AppTheme.textColor(context),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
