// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:mebel_mobile/presentation/components/app_text.dart';
// import 'package:mebel_mobile/presentation/routes/app_navigator.dart';
// import 'package:mebel_mobile/presentation/styles/app_colors.dart';
// import 'package:mebel_mobile/presentation/styles/app_theme.dart';

// class AppScaffold extends StatelessWidget {
//   final Widget child;
//   final Widget? title;
//   final List<Widget>? actions;
//   final bool backButtonWithCloseIcon;
//   final Widget? floatingActionButton;
//   final FloatingActionButtonLocation? floatingActionButtonLocation;
//   final bool withBackButton;
//   const AppScaffold({
//     Key? key,
//     required this.child,
//     this.backButtonWithCloseIcon = false,
//     this.floatingActionButton,
//     this.floatingActionButtonLocation,
//     this.actions,
//     this.withBackButton = true,
//     this.title,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.primaryColor(context),
//       appBar: AppBar(
//         leading: withBackButton
//             ? IconButton(
//                 splashRadius: 25,
//                 color: AppTheme.oppositePrimaryColor(context),
//                 icon: Hero(
//                     tag: "back_buttun",
//                     child: TweenAnimationBuilder<double>(
//                         curve: Curves.bounceInOut,
//                         duration: const Duration(milliseconds: 700),
//                         tween: Tween(begin: -pi / 2, end: 0),
//                         builder: (context, value, _) {
//                           return Transform.rotate(
//                               angle: value,
//                               child: Icon(backButtonWithCloseIcon
//                                   ? Icons.close
//                                   : Icons.arrow_back));
//                         })),
//                 onPressed: () => AppNavigator.back(),
//               )
//             : Container(),
//         elevation: 0,
//         actions: actions,
//         title: title,
//         backgroundColor: AppTheme.primaryColor(context),
//       ),
//       body: SafeArea(child: child),
//       floatingActionButtonLocation: floatingActionButtonLocation,
//       floatingActionButton: floatingActionButton,
//     );
//   }
// }
