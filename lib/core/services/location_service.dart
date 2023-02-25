// import 'package:location/location.dart';

// class LocationService {
//   Location location = new Location();

//   bool _serviceEnabled = false;
//   PermissionStatus? _permissionGranted;
//   LocationData? _locationData;

//   Future<LocationData?> getCurrentLocation() async {
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return null;
//       }
//     }

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return null;
//       }
//     }

//     _locationData = await location.getLocation();

//     return _locationData;
//   }
// }
