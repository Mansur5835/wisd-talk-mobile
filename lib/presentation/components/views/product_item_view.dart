import 'dart:math';
import 'package:flutter/material.dart';
import 'package:withtalk_mobile/core/utils/price_text.dart';
import 'package:withtalk_mobile/data/models/product.dart';
import 'package:withtalk_mobile/presentation/components/app_network_image.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';
import 'package:withtalk_mobile/presentation/pages/announcement_edit/announcement_edit_page.dart';
import 'package:withtalk_mobile/presentation/pages/product_detail/product_detail_page.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';
import '../../../core/utils/data_formater.dart';
import '../app_like_button.dart';

// ignore: must_be_immutable
class ProductItemView extends StatelessWidget {
  final ProductModel? productModel;
  String scrollDirection;
  bool productIsMy;
  Function()? likeTaped;
  Function()? backAction;
  ProductItemView(
      {super.key,
      this.productModel,
      this.scrollDirection = "none",
      this.productIsMy = false,
      this.likeTaped,
      this.backAction});

  double logicRorate() {
    if (scrollDirection == "none") return 0;
    if (scrollDirection == "up") return -pi / 10;
    if (scrollDirection == "down") return pi / 10;

    return 0.0;
  }

  String logicAddress(String? address) {
    if (address == null) return "";
    if (address.length > 9) {
      return address.substring(0, 9);
    }

    return address;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (productIsMy) {
          await AppNavigator.toNamed(AnnouncementEditPage.route, arguments: {
            "id": productModel?.id,
            "image": productModel?.image,
          });

          if (backAction == null) return;
          backAction!();
        } else {
          AppNavigator.toNamed(ProductDetailPage.route, arguments: {
            "id": productModel?.id,
            "image": productModel?.image
          });
        }
      },
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(logicRorate()),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: AppTheme.backColor(context),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _image(),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AppText(
                  PriceText.UZS(productModel?.price.toString()),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.oppositePrimaryColor(context),
                  size: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AppText(
                  productModel?.name ?? "",
                  color: AppTheme.oppositePrimaryColor(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    AppText(
                      logicAddress(productModel?.address),
                      size: 12,
                      color: AppTheme.oppositePrimaryColor(context),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: AppText(
                          DataFormater.dateToMobile(productModel?.date) ?? "",
                          color: AppTheme.oppositePrimaryColor(context),
                          size: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _image() {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: Hero(
              tag: productModel?.id ?? UniqueKey(),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: AppNetworkImage(
                  url: productModel?.image?["src"],
                  height: 220,
                  wight: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (!productIsMy)
            Container(
              alignment: Alignment.topRight,
              height: 220,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: AppLikeButton(
                  isFavorit: productModel?.like ?? false,
                  withBackground: true,
                  onTab: (isFav) async {
                    await client.favorite(
                        productId: productModel?.id, fav: isFav);
                    if (likeTaped == null) return;
                    likeTaped!();
                  },
                ),
              ),
            )
        ],
      ),
    );
  }
}
