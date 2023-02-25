import 'package:flutter/material.dart';
import 'package:withtalk_mobile/data/models/forum.dart';
import 'package:withtalk_mobile/presentation/components/views/user_avatar.dart';
import 'package:withtalk_mobile/presentation/pages/forum_detail/forum_detail_page.dart';
import 'package:withtalk_mobile/presentation/pages/my_forum/add_forum/add_forum_page.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_theme.dart';
import '../app_network_image.dart';
import '../app_text.dart';

class ForumView extends StatelessWidget {
  const ForumView(
      {super.key,
      this.forumModel,
      this.isEdit = false,
      required this.updateUI});
  final ForumModel? forumModel;
  final bool isEdit;
  final Function() updateUI;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: AppColors.grey1,
      color: AppTheme.backColor(context),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () async {
            if (isEdit) {
              await AppNavigator.to(AddForumPage(
                forumModel: forumModel,
              ));
              updateUI();
            } else {
              await AppNavigator.toNamed(ForumDetailPage.route,
                  arguments: forumModel);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    if (forumModel?.userPhoto == null)
                      Hero(
                        tag: forumModel?.id ?? UniqueKey(),
                        child: UserAvatar(
                          size: 50,
                        ),
                      )
                    else
                      Hero(
                        tag: forumModel?.id ?? UniqueKey(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3123),
                          child: AppNetworkImage(
                            url: forumModel?.userPhoto,
                            height: 50,
                            wight: 50,
                          ),
                        ),
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: AppText(
                        forumModel?.name,
                        color: AppTheme.oppositePrimaryColor(context),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: AppText(
                    forumModel?.text,
                    color: AppTheme.grey1(context),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: AppText(
                    forumModel?.date,
                    color: AppTheme.oppositePrimaryColor(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
