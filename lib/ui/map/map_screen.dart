import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_map/data/models/user_model.dart';
import 'package:google_map/provider/address_call_provider.dart';
import 'package:google_map/provider/user_location_provider.dart';
import 'package:google_map/ui/map/widgets/address_kind_selector.dart';
import 'package:google_map/ui/map/widgets/address_lang_selector.dart';
import 'package:google_map/ui/map/widgets/current%20_address_show.dart';
import 'package:google_map/utils/icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../provider/address_provider.dart';
import '../../provider/location_provider.dart';
import '../../utils/utility_functions.dart';
import '../app_routes.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.latLong});

  final LatLng latLong;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapType _selectedMapType = MapType.normal;
  late CameraPosition initialCameraPosition;
  late CameraPosition currentCameraPosition;
  bool onCameraMoveStarted = false;
  Set<Marker> markers = {};

  late LatLng _selectedLocation;
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  @override
  void initState() {
    LocationProvider locationProvider =
    Provider.of<LocationProvider>(context, listen: false);
    if (locationProvider.latLong != null) {
      addNewMarker(locationProvider.latLong!);
    }
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.initState();
    _selectedLocation = widget.latLong;
    initialCameraPosition = CameraPosition(target: _selectedLocation, zoom: 20);
    currentCameraPosition = CameraPosition(target: _selectedLocation, zoom: 15);
  }

  @override
  Widget build(BuildContext context) {
    final AddressProvider addressProvider =
    Provider.of<AddressProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarColor: Colors.black),
        toolbarHeight: 45,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImages.google,
              height: 40.h,
            ),
            SvgPicture.asset(
              AppImages.locationMe,
              height: 30.h,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          GoogleMap(
            markers: context
                .read<LocationProvider>()
                .markers,
            onCameraMove: (CameraPosition cameraPosition) {
              currentCameraPosition = cameraPosition;
            },
            padding: EdgeInsets.only(bottom: 20.r),
            mapType: _selectedMapType,
            mapToolbarEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onCameraMoveStarted: () {
              setState(() {
                onCameraMoveStarted = true;
              });
            },
            onMapCreated: (controller) {
              _controller.complete(controller);
            },
            onTap: (LatLng location) {
              setState(() {
                _selectedLocation = location;
              });
            },
            initialCameraPosition: CameraPosition(
              target: _selectedLocation,
              zoom: 15,
            ),
            onCameraIdle: () {
              context
                  .read<AddressCallProvider>()
                  .getAddressByLatLong(latLng: currentCameraPosition.target);
              setState(() {
                onCameraMoveStarted = false;
              });
            },
          ),
          Align(
            child: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: onCameraMoveStarted ? 50 : 32,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CurrentAddressField(),
          ),
          Positioned(
            right: 10,
            top: 20,
            child: ZoomTapAnimation(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.addressScreen);
              },
              child: Container(
                height: 33.h,
                width: 33.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: Colors.black.withOpacity(0.8)),
                child: Center(
                    child: Icon(Icons.list_alt_outlined,
                        color: addressProvider.savedAddressCondition
                            ? Colors.green
                            : Colors.white)),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 60,
            child: ZoomTapAnimation(
              onTap: () {
                followMe(cameraPosition: initialCameraPosition);
              },
              child: Container(
                height: 33.h,
                width: 33.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: Colors.black.withOpacity(0.8)),
                child: Center(
                  child: Icon(CupertinoIcons.location_solid,
                      color: _selectedLocation == widget.latLong
                          ? Colors.white
                          : Colors.red),
                ),
              ),
            ),
          ),
          Positioned(
            right: 3,
            top: 95,
            child: PopupMenuButton<MapType>(
              color: Colors.black.withOpacity(0.8),
              icon: Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: Colors.black.withOpacity(0.8)),
                child: Icon(Icons.map_rounded,
                    color: _selectedMapType == MapType.normal
                        ? Colors.white
                        : _selectedMapType == MapType.hybrid
                        ? Colors.green
                        : _selectedMapType == MapType.terrain
                        ? Colors.blue
                        : Colors.white),
              ),
              onSelected: (MapType result) {
                setState(() {
                  _selectedMapType = result;
                });
              },
              itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<MapType>>[
                PopupMenuItem<MapType>(
                  onTap: () {
                    setState(() {});
                  },
                  value: MapType.normal,
                  child: Row(
                    children: [
                      Text('Normal',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 15.sp)),
                      const Spacer(),
                      Image.asset(AppImages.normal, width: 50.w, height: 40.h),
                    ],
                  ),
                ),
                PopupMenuItem<MapType>(
                  onTap: () {
                    setState(() {});
                  },
                  value: MapType.hybrid,
                  child: Row(
                    children: [
                      Text('Hybrid',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 15.sp)),
                      const Spacer(),
                      Image.asset(AppImages.hybrid, width: 50.w, height: 40.h),
                    ],
                  ),
                ),
                PopupMenuItem<MapType>(
                  onTap: () {
                    setState(() {});
                  },
                  value: MapType.terrain,
                  child: Row(
                    children: [
                      Text('Terrain',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 15.sp)),
                      const Spacer(),
                      Image.asset(AppImages.terrain, width: 50.w, height: 40.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Positioned(top: 135, right: 2, child: AddressKindSelector()),
          const Positioned(top: 175, right: 2, child: AddressLangSelector()),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black.withOpacity(0.8),
        onPressed: () async {
          Provider.of<UserLocationsProvider>(context, listen: false)
              .insertUserAddress(
            UserAddress(
                id: DateTime
                    .now()
                    .millisecondsSinceEpoch,
                lat: currentCameraPosition.target.latitude,
                long: currentCameraPosition.target.longitude,
                address:
                context
                    .read<AddressCallProvider>()
                    .scrolledAddressText,
                created: DateTime.now().toString()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.black,
              content: Text(
                'Location successfully saved.',
                style: TextStyle(fontFamily: "Poppins", fontSize: 15.sp),
              ),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> followMe({required CameraPosition cameraPosition}) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

  addNewMarker(LatLng latLng) async {
      Uint8List uint8list = await getBytesFromAsset("assets/dot.png", 150);
    markers.add(Marker(
        markerId: MarkerId(
          DateTime.now().toString(),
        ),
        position: latLng,
        icon: BitmapDescriptor.fromBytes(uint8list),
        //BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
            title: "Samarqand", snippet: "Falonchi Ko'chasi 45-uy ")));
    setState(() {});
  }
}
