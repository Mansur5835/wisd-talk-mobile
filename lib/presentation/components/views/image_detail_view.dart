import 'package:flutter/material.dart';
import 'package:withtalk_mobile/presentation/components/app_zoom_image.dart';

import '../../../core/utils/assets_manager.dart';
import '../../routes/app_navigator.dart';
import '../../styles/app_colors.dart';
import '../../styles/app_theme.dart';
import '../app_network_image.dart';
import '../app_text.dart';
import '../buttons.dart';

class ImageDetailView extends StatefulWidget {
  final List<String> images;
  final String tag;
  const ImageDetailView({super.key, required this.images, required this.tag});

  @override
  State<ImageDetailView> createState() => _AppImageDetailViewState();
}

class _AppImageDetailViewState extends State<ImageDetailView> {
  PageController pageControllerImage = PageController();
  int _indexImage = 0;
  List<String> imagesAndVideos = [];
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagesAndVideos = widget.images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backColor(context),
      body: SafeArea(
        child: Container(
          color: AppTheme.backColor(context),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: Container(
                  color: AppTheme.backColor(context),
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: PageView(
                    onPageChanged: (index) {
                      _indexImage = index;
                      setState(() {});
                    },
                    controller: pageControllerImage,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(imagesAndVideos.length, (index) {
                      return Container(
                        alignment: Alignment.center,
                        child: Hero(
                          tag: widget.tag,
                          child: AppZoomImage(
                            child: AppNetworkImage(
                              url: imagesAndVideos[index],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: CustomButton.iconButton(
                    onTab: () {
                      AppNavigator.back();
                    },
                    child: Hero(
                      tag: "product_detail_image_back",
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryBlack05,
                        child: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          color: AppColors.white,
                          size: 25,
                        ),
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    CustomButton.iconButton(
                      onTab: () {
                        int toIndex = 0;
                        if (_indexImage == 0) {
                          toIndex = imagesAndVideos.length - 1;
                        } else {
                          toIndex = _indexImage - 1;
                        }

                        pageControllerImage.animateToPage(toIndex,
                            curve: Curves.fastOutSlowIn,
                            duration: const Duration(milliseconds: 300));
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryBlack05,
                        child: Icon(
                          Icons.chevron_left_rounded,
                          color: AppColors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    const Spacer(),
                    CustomButton.iconButton(
                      onTab: () {
                        int toIndex = 0;
                        if (_indexImage == imagesAndVideos.length - 1) {
                          toIndex = 0;
                        } else {
                          toIndex = _indexImage + 1;
                        }
                        pageControllerImage.animateToPage(toIndex,
                            curve: Curves.fastOutSlowIn,
                            duration: Duration(milliseconds: 300));
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryBlack05,
                        child: Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.white.withOpacity(0.9),
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                alignment: Alignment.topRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 50,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.2)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Hero(
                            tag: "image_counter",
                            child: Image.asset(
                              AssetsManager.icon(name: "image"),
                              width: 25,
                              height: 25,
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          AppText(
                            "${_indexImage + 1}/${imagesAndVideos.length}",
                            color: AppColors.white,
                            size: 16,
                          ),
                        ],
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
}
