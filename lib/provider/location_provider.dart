import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../utils/utility_functions.dart';

class LocationProvider with ChangeNotifier {
  LocationProvider() {
    _getLocation();
  }

  int count = 1;
  LatLng? latLong;

  Set<Marker> markers = {};

  Future<void> _getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    try {
      locationData = await location.getLocation();
      latLong = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );

      debugPrint("SUCCESS ERROR:${latLong!.longitude}");
      notifyListeners();
    } catch (er) {
      debugPrint("LOCATION ERROR:$er");
    }

    location.enableBackgroundMode(enable: true);

    location.onLocationChanged.listen((LocationData newLocation) async {
      Uint8List uint8list = count == 1
          ? await getBytesFromAsset("assets/courier.png", 150)
          : await getBytesFromAsset("assets/dot.png", 70);
      count++;
      markers.add(Marker(
          markerId: MarkerId(
            DateTime.now().toString(),
          ),
          position: LatLng(newLocation.latitude!, newLocation.longitude!),
          icon: BitmapDescriptor.fromBytes(uint8list),
          //BitmapDescriptor.defaultMarker,
          infoWindow: const InfoWindow(
              title: "Samarqand", snippet: "Falonchi Ko'chasi 45-uy ")));
      debugPrint("LONGITUDE:${newLocation.longitude}");
    });

    notifyListeners();
  }

  updateLatLong(LatLng newLatLng) {
    latLong = newLatLng;
    notifyListeners();
  }
}
