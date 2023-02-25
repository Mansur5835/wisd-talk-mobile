import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:withtalk_mobile/data/models/rating.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/app_text_field.dart';
import 'package:withtalk_mobile/presentation/components/buttons.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_colors.dart';

import '../../styles/app_theme.dart';

// ignore: must_be_immutable
class LeaveReviewView extends StatelessWidget {
  LeaveReviewView({super.key, required this.rating});

  final Function(Rating rating) rating;

  final Rating _rating = Rating();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.backColor(context),
          borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppTextField(
              label: "leave_comment_text".tr(),
              onChanged: (text) {
                _rating.comment = text;
              },
              color: AppColors.primaryColor01,
            ),
            RatingBar.builder(
              initialRating: _rating.rating,
              minRating: 1,
              direction: Axis.horizontal,
              glow: false,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40,
              unratedColor: AppColors.blackGrey1,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: AppColors.primaryColor,
              ),
              onRatingUpdate: (rating) {
                _rating.rating = rating;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.all(15),
              child: PrimaryButton(
                borderRadius: 10,
                onTap: () {
                  rating(_rating);
                  AppNavigator.back();
                },
                title: "leave_comment".tr(),
                backGroundColor: AppColors.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
