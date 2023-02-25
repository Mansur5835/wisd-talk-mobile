// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';

// class LaunchUtils {
//   late final List<AvailableMap> availableMaps;

//   init() async {
//     availableMaps = await MapLauncher.installedMaps;
//   }

//   Future<void> openMap(String? latitude, String? longitude,
//       {String? title, BuildContext? context}) async {
//     await init();
//     double lat = double.parse(latitude ?? "0");
//     double lon = double.parse(longitude ?? "0");

//     AppBottomSheet(
//             child: _openMapTypeView(context!, lat, lon, title),
//             title: "which_map_open".tr(),
//             height: availableMaps.length * 150)
//         .show();
//   }

//   Widget _openMapTypeView(BuildContext context, double lat, double lon,
//       [String? title]) {
//     return SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: List.generate(availableMaps.length, (index) {
//               return Container(
//                 child: ListTile(
//                   onTap: () async {
//                     print(availableMaps);
//                     await availableMaps[index].showMarker(
//                       coords: Coords(lat, lon),
//                       title: title ?? "MEBEL",
//                     );
//                   },
//                   leading: SvgPicture.asset(
//                     availableMaps[index].icon,
//                     height: 30.0,
//                     width: 30.0,
//                   ),
//                   title: AppText(
//                     availableMaps[index].mapName,
//                     size: 18,
//                     color: AppTheme.oppositePrimaryColor(context),
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
