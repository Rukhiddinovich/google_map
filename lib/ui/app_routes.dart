import 'package:flutter/material.dart';
import 'package:google_map/ui/map/map_screen.dart';
import 'package:google_map/ui/splash/splash_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteNames {
  static const String mapScreen = "/map";
  static const String addressScreen = "/addressScreen";
  static const String splashScreen = "/splashScreen";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.mapScreen:
        return MaterialPageRoute(
            builder: (context) => MapScreen(latLong: settings.arguments as LatLng,));
      case RouteNames.splashScreen:
        return MaterialPageRoute(
            builder: (context) => const SplashScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Route not found!"),
            ),
          ),
        );
    }
  }
}
