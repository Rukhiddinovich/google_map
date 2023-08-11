import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map/provider/api_provider.dart';
import 'package:google_map/ui/app_routes.dart';
import 'package:google_map/ui/location/get_location_screen.dart';
import 'package:google_map/utils/text_theme.dart';
import 'package:provider/provider.dart';
import 'data/network/api_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.initializeDatabase();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AddressProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,
          onGenerateRoute: AppRoutes.generateRoute,
          home: LocationAccess()
        );
      },
    );
  }
}
