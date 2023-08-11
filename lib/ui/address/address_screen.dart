import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../provider/api_provider.dart';
import '../../utils/icons.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);
    final addresses = addressProvider.addresses;

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
              addressProvider.deleteAllAddresses();
            },
            child: Text(
              'Clear',
              style: TextStyle(
                  color: Colors.red, fontFamily: "Poppins", fontSize: 18.sp),
            ),
          ),
        ],
      ),
      body: addresses.isEmpty
          ? Center(child: Lottie.asset(AppImages.location))
          : ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        address.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    'Lat: ${address.location.latitude}, Long: ${address.location.longitude}',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        fontFamily: "Poppins",
                        color: Colors.black),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      CupertinoIcons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      addressProvider.deleteAddress(index);
                    },
                  ),
                );
              },
            ),
    );
  }
}