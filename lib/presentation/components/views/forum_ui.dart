import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';
import 'package:withtalk_mobile/data/models/cotegory.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';
import 'package:withtalk_mobile/presentation/pages/forum/forum_page.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_colors.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';

class ForumUI extends StatefulWidget {
  final String? id;
  const ForumUI({super.key, required this.id, required this.bulder});

  final Function(int count, bool loading) bulder;

  @override
  State<ForumUI> createState() => _ForumUIState();
}

class _ForumUIState extends State<ForumUI> {
  List<CotegoryModel>? cotegories;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    setState(() {
      isLoading = true;
      widget.bulder(200, true);
    });

    var response = await client.cotegoryOfForum(categoryId: widget.id);

    setState(() {
      cotegories = response.data;
      isLoading = false;
      widget.bulder(cotegories?.length ?? 0, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? _shimmer()
        : Container(
            height: 200,
            child: Column(
              children: List.generate(cotegories?.length ?? 0, (index) {
                return Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppTheme.backColor(context)),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        AppNavigator.toNamed(ForumPage.route, arguments: {
                          "name": cotegories![index].name,
                          "id": cotegories![index].categoryId,
                        });
                      },
                      child: Row(
                        children: [
                          AppText(
                            cotegories![index].name,
                            color: AppTheme.oppositePrimaryColor(context),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: AppTheme.oppositePrimaryColor(context),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
  }

  Widget _shimmer() {
    return Container(
      height: 200,
      child: Column(
        children: List.generate(3, (index) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppTheme.backColor(context)),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Shimmer.fromColors(
                    baseColor: AppTheme.grey(context),
                    highlightColor: AppTheme.grey1(context),
                    child: Container(
                      width: 150,
                      height: 10,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(2)),
                    )),
                const Spacer(),
                Shimmer.fromColors(
                    baseColor: AppTheme.grey(context),
                    highlightColor: AppTheme.grey1(context),
                    child: Container(
                      width: 20,
                      height: 10,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(2)),
                    ))
              ],
            ),
          );
        }),
      ),
    );
  }
}
