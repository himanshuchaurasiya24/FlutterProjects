import 'package:flutter/material.dart';

Color primaryColor = Colors.red[200]!;
Color primaryCardColor = const Color.fromARGB(255, 239, 132, 132);

Color primaryColorDark = Colors.red[300]!;
Color primaryColorDarker = Colors.red[400]!;
double defaultSize = 20;
Color whitePrimary = Colors.white70;
double titleLargeTextSize = 50;
Color titleLargeTextColor = Colors.black87;
Color blackTile = Colors.black.withOpacity(0.7);
TextStyle patientHeader = const TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
);
TextStyle patientHeaderSmall = const TextStyle(
  fontSize: 20,
);
TextStyle patientChildrenHeading = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
);
double getDeviceHeight({required BuildContext context}) {
  return MediaQuery.of(context).size.height;
}

double getDeviceWidth({required BuildContext context}) {
  return MediaQuery.of(context).size.width;
}
