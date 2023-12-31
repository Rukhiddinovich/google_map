import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';

import '../../utils/icons.dart';
import '../map/map_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LatLong? _latLong;

  Future<void> _getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData? locationData;

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

    locationData = await location.getLocation();
    setState(() {
      _latLong = LatLong(
        latitude: locationData!.latitude!,
        longitude: locationData.longitude!,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await _getLocation();

    await Future.delayed(const Duration(seconds: 1));

    if (mounted && _latLong != null) {
      final LatLng latLng = LatLng(_latLong!.latitude, _latLong!.longitude);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MapScreen(latLong: latLng);
      }));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Lottie.asset(AppImages.till),
      ),
    );
  }
}

class LatLong {
  final double latitude;
  final double longitude;

  LatLong({required this.latitude, required this.longitude});
}