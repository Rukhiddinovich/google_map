// ignore_for_file: non_constant_identifier_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map/provider/address_call_provider.dart';
import 'package:provider/provider.dart';


class CurrentAddressField extends StatelessWidget {
  bool address = true;

  CurrentAddressField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      margin: const EdgeInsets.only(top: 5, left: 5, right: 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: Colors.black.withOpacity(0.8)),
      child: Text(
        context.read<AddressCallProvider>().scrolledAddressText,
        style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins"),
      ),
    );
  }
}
