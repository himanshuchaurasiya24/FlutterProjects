import 'package:flutter/material.dart';

Color primaryColorDark = const Color.fromARGB(255, 226, 226, 227);
// Color primaryColorDark = Color.fromARGB(255, 251, 222, 218);
Color primaryColorLite = const Color.fromARGB(237, 245, 246, 247);
Color btnColor = const Color(0xffff725e);
double defaultSize = 20;
double defaultPadding = 20;
double defaultBorderRadius = 20;
double titleLargeTextSize = 50;
Color blackTile = Colors.black.withOpacity(0.7);
TextStyle appbar = const TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
);
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
// Color primaryColor = Colors.red[200]!;
// Color whitePrimary = Colors.white70;
// Color primaryColor = const Color(0xffb1b1b1);
// Color primaryCardColor = Colors.red[400]!;

// Color primaryColorDark = Colors.red[300]!;
// Color primaryColorDarker = Colors.red[400]!;
// Color primaryColorDarker = Colors.red[400]!;
