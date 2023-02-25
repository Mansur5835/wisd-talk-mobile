import 'package:flutter/material.dart';
import 'package:withtalk_mobile/presentation/components/app_page.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_widget.dart';
import 'package:withtalk_mobile/presentation/pages/user_self_announ/cubit/user_self_announ_cubit.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';
import '../../components/app_load_item_widget.dart';
import '../../components/views/product_item_view.dart';

// ignore: must_be_immutable
class UserSelfAnnounPage
    extends AppPage<UserSelfAnnounCubit, UserSelfAnnounState> {
  static const String route = "/user_self_announ_page";

  UserSelfAnnounPage({super.key});

  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context, state) {
    return Scaffold(
        backgroundColor: AppTheme.primaryColor(context),
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              AppNavigator.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: AppTheme.oppositePrimaryColor(context),
            ),
          ),
          elevation: 0,
          backgroundColor: AppTheme.primaryColor(context),
          title: AppText(
            state.title,
            fontWeight: FontWeight.w500,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: AppLoadItemView(
                          parentScrollController: scrollController,
                          loadMore: cubit.loadMore,
                          items: List.generate(state.products?.length ?? 0,
                              (index) {
                            return ProductItemView(
                              backAction: () {
                                cubit.loadData();
                              },
                              productIsMy: !cubit.isOtherUser,
                              productModel: state.products![index],
                            );
                          })),
                    ),
                  ],
                ),
              ));
  }
}
