import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../provider/address_call_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/icons.dart';

class AddressLangSelector extends StatefulWidget {
  const AddressLangSelector({Key? key}) : super(key: key);

  @override
  State<AddressLangSelector> createState() => _AddressLangSelectorState();
}

class _AddressLangSelectorState extends State<AddressLangSelector> {
  String selectedLang = langList.first;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.black.withOpacity(0.8),
      icon: Container(
        height: 33.h,
        width: 33.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            color: Colors.black.withOpacity(0.8)),
        child: const Icon(
          Icons.language,
          color: Colors.white,
        ),
      ),
      initialValue: selectedLang,
      onSelected: (String value) {
        setState(() {
          selectedLang = value;
        });

        context.read<AddressCallProvider>().updateLang(selectedLang);
      },
      itemBuilder: (BuildContext context) {
        return langList.asMap().entries.map<PopupMenuEntry<String>>(
          (MapEntry<int, String> entry) {
            int index = entry.key;
            String value = entry.value;
            PopupMenuItem<MapEntry>(
              onTap: () {
                setState(() {});
              },
              // value: MapEntry,
              child: Row(
                children: [
                  Text("UZB",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 15.sp)),
                  const Spacer(),
                  SvgPicture.asset(
                    AppImages.uzb,
                    width: 30.w,
                    height: 30,
                  ),
                ],
              ),
            );
            PopupMenuItem<MapEntry>(
              onTap: () {
                setState(() {});
              },
              // value: MapEntry.hybrid,
              child: Row(
                children: [
                  Text("RUS",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 15.sp)),
                  const Spacer(),
                  SvgPicture.asset(
                    AppImages.rus,
                    width: 30.w,
                    height: 30,
                  ),
                ],
              ),
            );
            PopupMenuItem<MapEntry>(
              onTap: () {
                setState(() {});
              },
              // value: MapEntry.hybrid,
              child: Row(
                children: [
                  Text("ENG",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 15.sp)),
                  const Spacer(),
                  SvgPicture.asset(
                    AppImages.usa,
                    width: 30.w,
                    height: 30,
                  ),
                ],
              ),
            );
            PopupMenuItem<MapEntry>(
              onTap: () {
                setState(() {});
              },
              // value: MapEntry.hybrid,
              child: Row(
                children: [
                  Text("TURK",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 15.sp)),
                  const Spacer(),
                  SvgPicture.asset(
                    AppImages.turk,
                    width: 30.w,
                    height: 30,
                  ),
                ],
              ),
            );

            String text;
            switch (index) {
              case 1:
                PopupMenuItem<MapEntry>(
                  onTap: () {
                    setState(() {});
                  },
                  // value: MapEntry.hybrid,
                  child: Row(
                    children: [
                      Text("RUS",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 15.sp)),
                      const Spacer(),
                      SvgPicture.asset(
                        AppImages.rus,
                        width: 30.w,
                        height: 30,
                      ),
                    ],
                  ),
                );
                text = 'Русский';
                break;
              case 2:
                text = 'English';
                break;
              case 3:
                text = 'Turkish';
                break;
              default:
                text = 'Uzbek';
            }
            return PopupMenuItem<String>(
              value: value,
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontSize: 15.sp),
              ),
            );
          },
        ).toList();
      },
    );
  }
}
