import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map/data/models/user_model.dart';
import 'package:google_map/provider/user_location_provider.dart';
import 'package:google_map/ui/map/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../provider/location_provider.dart';
import '../../utils/icons.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    List<UserAddress> userAddress =
        Provider.of<UserLocationsProvider>(context).addresses;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.black),
        backgroundColor: Colors.black,
        title: Text(
          "Location",
          style: TextStyle(
              fontSize: 22.sp,
              color: Colors.white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<UserLocationsProvider>().deleteAllUserAddress();
            },
            child: Text(
              'Clear',
              style: TextStyle(
                  color: Colors.red, fontFamily: "Poppins", fontSize: 18.sp),
            ),
          ),
        ],
      ),
      body: userAddress.isEmpty
          ? Center(child: Lottie.asset(AppImages.location))
          : ListView.builder(
              itemCount: userAddress.length,
              itemBuilder: (context, index) {
                final address = userAddress[index];
                return ListTile(
                  onTap: () {
                    currentCameraPosition = CameraPosition(target:  LatLng(address.lat, address.long),zoom: 15);
                    onTap.call();
                    Navigator.pop(context);
                  },
                  subtitle: Text(
                    address.address,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      CupertinoIcons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      context
                          .read<UserLocationsProvider>()
                          .deleteUserAddress(address.id ?? 1);
                    },
                  ),
                );
              },
            ),
    );
  }
}
