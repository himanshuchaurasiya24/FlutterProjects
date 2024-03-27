import 'package:flutter/material.dart';
import 'package:vyavasaay_redesigned/screens/model/menu_details.dart';
import 'package:vyavasaay_redesigned/screens/pages/about_this_app.dart';
import 'package:vyavasaay_redesigned/screens/pages/access_control.dart';
import 'package:vyavasaay_redesigned/screens/pages/account_details.dart';
import 'package:vyavasaay_redesigned/screens/pages/dashboard.dart';
import 'package:vyavasaay_redesigned/screens/pages/diagnosis_history.dart';
import 'package:vyavasaay_redesigned/screens/pages/doctor_info.dart';
import 'package:vyavasaay_redesigned/screens/pages/generate_report.dart';
import 'package:vyavasaay_redesigned/screens/pages/login_history.dart';
import 'package:vyavasaay_redesigned/screens/pages/logout.dart';

class MenuItems {
  List<MenuDetails> adminMenuItems = [
    MenuDetails(
      title: 'Dashboard',
      icon: Icons.dashboard_outlined,
      child: const Dashboard(),
    ),
    MenuDetails(
      title: 'Generate Report',
      icon: Icons.report_outlined,
      child: const GenerateReport(),
    ),
    MenuDetails(
      title: 'Doctor Info',
      icon: Icons.person_outlined,
      child: const DoctorInfo(),
    ),
    MenuDetails(
      title: 'Diagnosis History',
      icon: Icons.work_history_outlined,
      child: const DiagnosisHistory(),
    ),
    MenuDetails(
      title: 'Account Details',
      icon: Icons.account_circle_outlined,
      child: const AccountDetails(),
    ),
    MenuDetails(
      title: 'About This App',
      icon: Icons.info_outline,
      child: const AboutThisApp(),
    ),
    MenuDetails(
      title: 'Access Control',
      icon: Icons.shield_outlined,
      child: const AccessControl(),
    ),
    MenuDetails(
      title: 'Login History',
      icon: Icons.location_history_outlined,
      child: const LoginHistory(),
    ),
    MenuDetails(
      title: 'Log Out',
      icon: Icons.logout_outlined,
      child: Logout(),
    )
  ];
  List<MenuDetails> usersMenuItems = [
    MenuDetails(
      title: 'Dashboard',
      icon: Icons.dashboard_outlined,
      child: const Dashboard(),
    ),
    MenuDetails(
      title: 'Generate Report',
      icon: Icons.report_outlined,
      child: const GenerateReport(),
    ),
    MenuDetails(
      title: 'Doctor Info',
      icon: Icons.person_outlined,
      child: const DoctorInfo(),
    ),
    MenuDetails(
      title: 'Diagnosis History',
      icon: Icons.work_history_outlined,
      child: const DiagnosisHistory(),
    ),
    MenuDetails(
      title: 'Account Details',
      icon: Icons.account_circle_outlined,
      child: const AccountDetails(),
    ),
    MenuDetails(
      title: 'About This App',
      icon: Icons.info_outline,
      child: const AboutThisApp(),
    ),
    MenuDetails(
      title: 'Log Out',
      icon: Icons.logout_outlined,
      child: Logout(),
    )
  ];
}
