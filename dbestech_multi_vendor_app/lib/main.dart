import 'package:dbestech_multi_vendor_app/constants/constants.dart';
import 'package:dbestech_multi_vendor_app/views/entrypoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget defaultHome = MainScreen();
void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(375, 825),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MultiVendorApp',
          theme: ThemeData(
              scaffoldBackgroundColor: kOffWhite,
              iconTheme: const IconThemeData(color: kDark),
              primarySwatch: Colors.grey),
          home: defaultHome,
        );
      },
    );
  }
}
