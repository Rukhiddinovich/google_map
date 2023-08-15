import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map/data/models/user_model.dart';
import 'package:google_map/provider/user_location_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../utils/icons.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});

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
              context.read<UserLocationsProvider>().deleteUserAddress(1);
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
                  onTap: () {},
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
                      context.read<UserLocationsProvider>().deleteUserAddress(index);
                    },
                  ),
                );
              },
            ),
    );
  }
}
