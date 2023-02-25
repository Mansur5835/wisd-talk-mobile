import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:withtalk_mobile/data/models/app_http_response.dart';
import 'package:withtalk_mobile/data/models/cotegory.dart';
import 'package:withtalk_mobile/presentation/components/animation/slide_and_opasity_animation.dart';
import 'package:withtalk_mobile/presentation/components/app_network_image.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_colors.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';

class AppSelectCotegoryView extends StatefulWidget {
  static const String route = "/select_cotegories";
  const AppSelectCotegoryView({super.key});

  @override
  State<AppSelectCotegoryView> createState() => _AppSelectCotegoryViewState();
}

class _AppSelectCotegoryViewState extends State<AppSelectCotegoryView> {
  List<CotegoryModel>? list;
  List<CotegoryModel>? listSub;

  bool isloading = false;
  bool isloadingSub = false;
  int _index = 100;

  bool isForumCotegories = false;

  @override
  void initState() {
    isForumCotegories = args.get ?? false;
    _loadData();
    super.initState();
  }

  _loadData() async {
    setState(() {
      isloading = true;
    });
    AppHttpResponse? response;

    if (!isForumCotegories) {
      response = await client.cotigories();
    } else {
      response = await client.cotegoryOfForum();
    }

    setState(() {
      list = response?.data;
      isloading = false;
    });
  }

  getSubCotegories(int index) async {
    setState(() {
      listSub = null;
      _index = 100;
      isloadingSub = true;
      _index = index;
    });

    AppHttpResponse? response;

    if (!isForumCotegories) {
      response = await client.cotigories(categoryId: list![index].categoryId);
    } else {
      response =
          await client.cotegoryOfForum(categoryId: list![index].categoryId);
    }

    setState(() {
      listSub = response?.data;
      isloadingSub = false;
    });
  }

  Widget logicName(int index) {
    if (isloadingSub && (index == _index)) {
      return Shimmer.fromColors(
        baseColor: AppTheme.oppositePrimaryColor(context),
        highlightColor: AppTheme.primaryColor(context),
        child: SizedBox(
          width: 200,
          height: 15,
          child: AppText(
            list![index].name,
            color: AppTheme.oppositePrimaryColor(context),
          ),
        ),
      );
    } else {
      return AppText(
        list![index].name,
        color: index == _index
            ? AppColors.primaryColor
            : AppTheme.oppositePrimaryColor(context),
        fontWeight: index == _index ? FontWeight.bold : null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor(context),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            AppNavigator.back();
          },
          child: Icon(
            Icons.arrow_back_outlined,
            color: AppTheme.oppositePrimaryColor(context),
          ),
        ),
        elevation: 0,
        backgroundColor: AppTheme.primaryColor(context),
        title: isloading
            ? Container(
                width: 500,
                height: 30,
                alignment: Alignment.centerLeft,
                child: Shimmer.fromColors(
                  baseColor: AppTheme.oppositePrimaryColor(context),
                  highlightColor: AppTheme.primaryColor(context),
                  child: AppText(
                    "cotegories".tr(),
                    color: AppTheme.oppositePrimaryColor(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Container(
                alignment: Alignment.centerLeft,
                child: AppText(
                  "cotegories".tr(),
                  color: AppTheme.oppositePrimaryColor(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(list?.length ?? 0, (index) {
              return SlideAndOpasityAnimation(
                opasityDuration: 80,
                slideDuration: ((index + 1)) * 100,
                child: GestureDetector(
                  onTap: () async {
                    getSubCotegories(index);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: AppTheme.backColor(context),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            if (list![index].icon != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(312312),
                                child: AppNetworkImage(
                                  url: list![index].icon,
                                  wight: 50,
                                  height: 50,
                                ),
                              ),
                            const SizedBox(
                              width: 10,
                            ),
                            logicName(index),
                            const Spacer(),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppTheme.oppositePrimaryColor(context),
                            )
                          ],
                        ),
                        if (_index == index && isloadingSub == false) ...{
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: isForumCotegories ? 20 : 60, top: 15),
                            alignment: Alignment.centerLeft,
                            child: AppText(
                              "sub_cotegories".tr(),
                              textAlign: TextAlign.right,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.oppositePrimaryColor(context),
                            ),
                          ),
                          ...List.generate(listSub?.length ?? 0, (index) {
                            return GestureDetector(
                              onTap: () {
                                AppNavigator.back(result: listSub![index]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: isForumCotegories ? 20 : 60, top: 15),
                                alignment: Alignment.centerLeft,
                                child: AppText(
                                  listSub![index].name,
                                  textAlign: TextAlign.right,
                                  color: AppTheme.oppositePrimaryColor(context),
                                ),
                              ),
                            );
                          })
                        }
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
