import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../provider/address_call_provider.dart';
import '../../../utils/constants.dart';

class AddressKindSelector extends StatefulWidget {
  const AddressKindSelector({Key? key}) : super(key: key);

  @override
  State<AddressKindSelector> createState() => _AddressKindSelectorState();
}

class _AddressKindSelectorState extends State<AddressKindSelector> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.black.withOpacity(0.8),
      icon: Container(
        height: 50.h,
        width: 50.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            color: Colors.black.withOpacity(0.8)),
        child: selectedIndex == 0
            ? const Center(
                child: Icon(CupertinoIcons.house_alt_fill,
                    color: Colors.green, size: 18))
            : selectedIndex == 1
                ? const Center(
                    child: Icon(Icons.directions_subway,
                        color: Colors.blueAccent, size: 20),
                  )
                : selectedIndex == 2
                    ? const Center(
                        child: Icon(CupertinoIcons.location_solid,
                            color: Colors.red, size: 20),
                      )
                    : const Center(
                        child: Icon(Icons.line_axis,
                            color: Colors.grey, size: 20)),
      ),
      initialValue: selectedIndex,
      onSelected: (int index) {
        setState(() {
          selectedIndex = index;
        });
        String selectedValue = kindList[index];
        context.read<AddressCallProvider>().updateKind(selectedValue);
      },
      itemBuilder: (BuildContext context) {
        return kindList.asMap().entries.map(
          (MapEntry<int, String> entry) {
            int index = entry.key;
            IconData iconData;
            switch (index) {
              case 1:
                iconData = Icons.directions_subway;
                break;
              case 2:
                iconData = CupertinoIcons.location_solid;
                break;
              case 3:
                iconData = Icons.line_axis;
                break;
              default:
                iconData = CupertinoIcons.house_alt_fill;
            }

            String text;
            switch (index) {
              case 1:
                text = 'Subway';
                break;
              case 2:
                text = 'District';
                break;
              case 3:
                text = 'Street';
                break;
              default:
                text = 'Home';
            }
            return PopupMenuItem<int>(
              value: index,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(iconData, color: Colors.white),
                  SizedBox(width: 10.w),
                  Text(text,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: "Poppins"),
                  ),
                ],
              ),
            );
          },
        ).toList();
      },
    );
  }
}
//boldi hc qatini bosmen