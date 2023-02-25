import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:withtalk_mobile/data/models/cotegory.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/pages/cotegory/cotegory_page.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';

import '../app_network_image.dart';

class CotegoryView extends StatelessWidget {
  final CotegoryModel? cotegoryModel;
  const CotegoryView({super.key, this.cotegoryModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.toNamed(CotegoryPage.route, arguments: {
          "id": cotegoryModel?.categoryId,
          "name": cotegoryModel?.name
        });
      },
      child: Container(
        height: 140,
        width: 100,
        margin: const EdgeInsets.only(
          right: 10,
        ),
        decoration: BoxDecoration(
          color: AppTheme.backColor(context),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(12312),
              child: AppNetworkImage(
                url: cotegoryModel?.icon,
                wight: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
            AppText(
              cotegoryModel?.name,
              fontWeight: FontWeight.w700,
              color: AppTheme.oppositePrimaryColor(context),
            ),
            SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
