import 'package:flutter/material.dart';

Color primaryColor = Colors.red[200]!;
Color primaryColorDark = Colors.red[300]!;
Color primaryColorDarker = Colors.red[400]!;
double defaultSize = 20;
Color whitePrimary = Colors.white70;
double titleLargeTextSize = 50;
Color titleLargeTextColor = Colors.black87;
Color blackTile = Colors.black.withOpacity(0.7);
double getDeviceHeight({required BuildContext context}) {
  return MediaQuery.of(context).size.height;
}

double getDeviceWidth({required BuildContext context}) {
  return MediaQuery.of(context).size.width;
}
