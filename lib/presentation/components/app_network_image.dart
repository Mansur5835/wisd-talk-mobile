import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:shimmer/shimmer.dart';
import 'package:withtalk_mobile/presentation/styles/app_colors.dart';

import '../../data/constants/apis.dart';

class AppNetworkImage extends StatelessWidget {
  final double? wight;
  final double? height;
  final String? url;
  final String? otherUrl;
  final Alignment? alignment;

  final Color? color;
  final BoxFit? fit;
  const AppNetworkImage(
      {super.key,
      this.otherUrl,
      this.color,
      this.alignment,
      this.fit,
      this.url,
      this.height,
      this.wight});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: wight,
      height: height,
      color: color,
      alignment: alignment ?? Alignment.center,
      fit: fit ?? BoxFit.cover,
      imageUrl: otherUrl ?? (Apis.baseImageUrl + url.toString()),
      placeholder: (context, url) => _shimmerPlaceholder(),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        // color: AppTheme.oppositePrimaryColor(context),
        size: 40,
      ),
    );
  }

  _shimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: AppColors.grey,
      highlightColor: AppColors.white,
      child: Container(
        width: wight,
        height: height,
        color: Colors.white,
      ),
    );
  }
}
