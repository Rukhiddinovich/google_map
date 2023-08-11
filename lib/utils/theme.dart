import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
    ),
    iconTheme: const IconThemeData(color: Colors.grey),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(color: Colors.white, fontSize: 14.sp),
      titleSmall: TextStyle(color: Colors.white, fontSize: 12.sp),
    ),
    popupMenuTheme: PopupMenuThemeData(
        shape: Border.all(color: Colors.red,width: 2.w),
        color: Colors.black,
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
        )),
  );
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
    ),
    popupMenuTheme: PopupMenuThemeData(
        color: Colors.white,
        textStyle: TextStyle(color: Colors.black, fontSize: 12.sp)),
    iconTheme: const IconThemeData(color: Colors.grey),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(color: Colors.black, fontSize: 14.sp),
      titleSmall: TextStyle(color: Colors.black, fontSize: 12.sp),
    ),
  );
}