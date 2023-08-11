import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_map/utils/icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../data/models/map/map_model.dart';
import '../../provider/api_provider.dart';
import '../app_routes.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.latLong});

  final LatLng latLong;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapType _selectedMapType = MapType.normal;
  late GoogleMapController _mapController;
  late CameraPosition initialCameraPosition;
  late LatLng _selectedLocation;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.initState();
    Provider.of<AddressProvider>(context, listen: false).loadAddresses();
    _selectedLocation = widget.latLong;
    initialCameraPosition = CameraPosition(target: _selectedLocation, zoom: 15);
  }

  @override
  Widget build(BuildContext context) {
    final AddressProvider addressProvider =
        Provider.of<AddressProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.black),
        toolbarHeight: 40,
        title: SvgPicture.asset(AppImages.google,height: 45.h,),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.addressScreen);
              },
              icon: const Icon(Icons.list_alt))
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: 25.r),
            mapType: _selectedMapType,
            mapToolbarEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (controller) {
              _mapController = controller;
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
            markers: <Marker>{
              Marker(
                markerId: const MarkerId('selectedLocation'),
                position: _selectedLocation,
              ),
            },
          ),
          Positioned(
            right: 10,
            top: 60,
            child: ZoomTapAnimation(
              onTap: () {
                setState(() {
                  _selectedLocation = widget.latLong;
                  initialCameraPosition =
                      CameraPosition(target: _selectedLocation, zoom: 15);
                });
              },
              child: Container(
                height: 33.h,
                width: 33.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: Colors.black.withOpacity(0.8)),
                child: const Center(
                  child: Icon(
                    CupertinoIcons.compass_fill,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 3,
            top: 100,
            child: PopupMenuButton<MapType>(
              color: Colors.black.withOpacity(0.8),
              icon: Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: Colors.black.withOpacity(0.8)),
                child: const Icon(Icons.map_rounded, color: Colors.white),
              ),
              onSelected: (MapType result) {
                setState(() {
                  _selectedMapType = result;
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<MapType>>[
                PopupMenuItem<MapType>(
                  onTap: () {
                    setState(() {});
                  },
                  value: MapType.normal,
                  child: Text('Normal',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 15.sp)),
                ),
                PopupMenuItem<MapType>(
                  onTap: () {
                    setState(() {});
                  },
                  value: MapType.hybrid,
                  child: Text('Hybrid',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 15.sp)),
                ),
                PopupMenuItem<MapType>(
                  onTap: () {
                    setState(() {});
                  },
                  value: MapType.terrain,
                  child: Text('Terrain',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 15.sp)),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          Provider.of<AddressProvider>(context, listen: false).addAddress(
            Address(
              id: DateTime.now().millisecondsSinceEpoch,
              name: 'Location',
              location: Location(
                latitude: _selectedLocation.latitude,
                longitude: _selectedLocation.longitude,
              ),
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.black,
              content: Text(
                'Location successfully saved.',
                style: TextStyle(fontFamily: "Poppins",fontSize: 15.sp),
              ),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
