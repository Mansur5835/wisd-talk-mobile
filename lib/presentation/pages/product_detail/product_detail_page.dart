import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:withtalk_mobile/core/utils/assets_manager.dart';
import 'package:withtalk_mobile/core/utils/data_formater.dart';
import 'package:withtalk_mobile/core/utils/price_text.dart';
import 'package:withtalk_mobile/core/utils/screen_size.dart';
import 'package:withtalk_mobile/presentation/components/animation/slide_and_opasity_animation.dart';
import 'package:withtalk_mobile/presentation/components/app_bottom_sheet.dart';
import 'package:withtalk_mobile/presentation/components/app_network_image.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/buttons.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';
import 'package:withtalk_mobile/presentation/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/product_detail/cubit/product_detail_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/user_self_announ/user_self_announ_page.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_colors.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';
import '../../components/app_like_button.dart';
import '../../components/views/image_detail_view.dart';
import '../../components/views/leave_review_view.dart';
import '../../components/views/user_avatar.dart';

class ProductDetailPage extends StatefulWidget {
  static const String route = "/product_detail_page";
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late ProductDetailCubit cubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailCubit()..init(),
      child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        builder: (context, state) {
          cubit = BlocProvider.of<ProductDetailCubit>(context);
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              height: 50,
              color: AppTheme.backColor(context),
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CustomButton(
                      borderRadius: 10,
                      color: AppColors.primaryColor,
                      hiegth: 40,
                      child: AppText("call_or_sms".tr()),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: SizedBox(
                    height: 40,
                    child: AppOutlinedButton(
                      onTap: () async {},
                      color: AppColors.primaryColor,
                      label: 'chat'.tr(),
                    ),
                  )),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            backgroundColor: AppTheme.primaryColor(context),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _image(state),
                    if (state.productDetailModel != null) ...{
                      SlideAndOpasityAnimation(
                          opasityDuration: 0,
                          slideDuration: 500,
                          child: _name(state)),
                      SlideAndOpasityAnimation(
                          opasityDuration: 0,
                          slideDuration: 600,
                          child: _price(state)),
                      SlideAndOpasityAnimation(
                          opasityDuration: 0,
                          slideDuration: 700,
                          child: _viewAndLike(state)),
                      SlideAndOpasityAnimation(
                          opasityDuration: 0,
                          slideDuration: 800,
                          child: _user(state)),
                      SlideAndOpasityAnimation(
                          opasityDuration: 0,
                          slideDuration: 900,
                          child: _descreption(state)),
                      SlideAndOpasityAnimation(
                          opasityDuration: 0,
                          slideDuration: 1000,
                          child: _address(state)),
                      _reviews(state)
                    },
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _reviews(ProductDetailState _state) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.backColor(context)),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: AppText(
                  "${"reviews".tr()} (${_state.reviews?.length ?? 0})",
                  color: AppTheme.oppositePrimaryColor(context),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  state.user?.photo == null
                      ? UserAvatar(
                          size: 60,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(312312),
                          child: AppNetworkImage(
                            url: state.user?.photo,
                            wight: 60,
                            height: 60,
                          ),
                        ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        AppBottomSheet(
                                withTitle: false,
                                child: LeaveReviewView(
                                  rating: (rating) {
                                    cubit.leaveReaview(rating);
                                  },
                                ),
                                height: 400)
                            .show();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primaryColor01),
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        child: AppText(
                          "leave_comment".tr(),
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ...List.generate(_state.reviews?.length ?? 0, (index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(1332),
                            child: AppNetworkImage(
                              url: _state.reviews![index].user?.personalPhoto,
                              wight: 50,
                              height: 50,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          AppText(
                            _state.reviews![index].user?.name,
                            color: AppTheme.oppositePrimaryColor(context),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          RatingBarIndicator(
                              rating: (_state.reviews![index].rating ?? 0.0),
                              itemCount: 5,
                              itemSize: 20,
                              unratedColor: AppTheme.grey(context),
                              itemBuilder: ((context, index) {
                                return Icon(
                                  Icons.star_rate_rounded,
                                  color: AppColors.primaryColor,
                                );
                              })),
                          const SizedBox(
                            width: 10,
                          ),
                          AppText(
                            _state.reviews![index].date,
                            color: AppTheme.grey1(context),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppText(
                        _state.reviews![index].text,
                        color: AppTheme.oppositePrimaryColor(context),
                      )
                    ],
                  ),
                );
              })
            ],
          ),
        );
      },
    );
  }

  Widget _address(ProductDetailState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: AppText(
              "address".tr(),
              color: AppTheme.oppositePrimaryColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: AppText(
              (state.productDetailModel?.address),
              color: AppTheme.oppositePrimaryColor(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _descreption(ProductDetailState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: AppText(
              "descreption".tr(),
              color: AppTheme.oppositePrimaryColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: AppText(
              state.productDetailModel?.detailText,
              color: AppTheme.oppositePrimaryColor(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _user(ProductDetailState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: AppText(
              "ofter_of_announcement".tr(),
              color: AppTheme.oppositePrimaryColor(context),
              size: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              if (state.productDetailModel?.userPhoto == null)
                UserAvatar(
                  size: 60,
                )
              else
                ClipRRect(
                  borderRadius: BorderRadius.circular(123),
                  child: AppNetworkImage(
                    url: state.productDetailModel?.userPhoto,
                    wight: 60,
                    height: 60,
                  ),
                ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    state.productDetailModel?.userName ?? "",
                    color: AppTheme.oppositePrimaryColor(context),
                    size: 16,
                  ),
                  RatingBarIndicator(
                      rating: (state.productDetailModel?.reting ?? 0.0),
                      itemCount: 5,
                      itemSize: 35,
                      unratedColor: AppTheme.grey(context),
                      itemBuilder: ((context, index) {
                        return Icon(
                          Icons.star_rate_rounded,
                          color: AppColors.primaryColor,
                        );
                      })),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                AppNavigator.toNamed(UserSelfAnnounPage.route, arguments: {
                  "title": state.productDetailModel?.userName,
                  "id": state.productDetailModel?.userId,
                  "user": true
                });
              },
              child: Row(
                children: [
                  AppText(
                    "other_announcement".tr(),
                    color: AppTheme.oppositePrimaryColor(context),
                    size: 15,
                  ),
                  Icon(
                    Icons.navigate_next_rounded,
                    color: AppTheme.oppositePrimaryColor(context),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _viewAndLike(ProductDetailState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              width: 300,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    "${"views".tr()}:  ${state.productDetailModel?.count ?? "0"}",
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.detailButtunColor),
            child: AppLikeButton(
              isFavorit: state.productDetailModel?.like ?? false,
              size: 30,
              color: AppColors.primaryColor,
              onTab: (isLiked) async {
                await client.favorite(
                    productId: state.productDetailModel?.id, fav: isLiked);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _price(ProductDetailState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: AppText(
              PriceText.UZS(state.productDetailModel?.price),
              color: AppTheme.oppositePrimaryColor(context),
              fontWeight: FontWeight.bold,
              size: 23,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: AppText(
              DataFormater.dateToMobile(state.productDetailModel?.date),
              color: AppTheme.grey1(context),
            ),
          )
        ],
      ),
    );
  }

  Widget _name(ProductDetailState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Container(
        alignment: Alignment.centerLeft,
        child: AppText(
          state.productDetailModel?.name,
          color: AppTheme.oppositePrimaryColor(context),
          size: 18,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _image(ProductDetailState state) {
    return GestureDetector(
      onTap: () {
        AppNavigator.to(ImageDetailView(
          images: state.images ?? [],
          tag: cubit.id ?? UniqueKey().toString(),
        ));
      },
      child: Container(
        alignment: Alignment.center,
        color: AppTheme.backColor(context),
        height: ScreenSize.size().width,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Hero(
                tag: cubit.id ?? UniqueKey(),
                child: AppNetworkImage(
                  url: state.images?[0],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  AppNavigator.back();
                },
                child: Hero(
                  tag: "product_detail_image_back",
                  child: CircleAvatar(
                    backgroundColor: AppColors.primaryBlack05,
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryBlack05),
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      state.images?.length.toString(),
                      color: AppColors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Hero(
                      tag: "image_counter",
                      child: Image.asset(
                        AssetsManager.icon(name: "image"),
                        width: 30,
                        height: 30,
                        color: AppColors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
