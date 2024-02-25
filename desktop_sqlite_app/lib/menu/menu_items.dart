import 'package:desktop_sqlite_app/menu/menu_details.dart';
import 'package:desktop_sqlite_app/menu/pages/accounts.dart';
import 'package:desktop_sqlite_app/menu/pages/dashboard.dart';
import 'package:desktop_sqlite_app/menu/pages/notifications.dart';
import 'package:desktop_sqlite_app/menu/pages/reports.dart';
import 'package:desktop_sqlite_app/menu/pages/settings.dart';
import 'package:flutter/material.dart';

class MenuItems {
  List<MenuDetails> items = [
    MenuDetails(
      title: 'Dashboard',
      icon: Icons.home,
      page: const Dashboard(),
    ),
    MenuDetails(
      title: 'Accounts',
      icon: Icons.account_circle_rounded,
      page: const Accounts(),
    ),
    MenuDetails(
      title: 'Notifications',
      icon: Icons.notification_important_rounded,
      page: const Notifications(),
    ),
    MenuDetails(
      title: 'Reports',
      icon: Icons.add_chart,
      page: const Reports(),
    ),
    MenuDetails(
      title: 'Settings',
      icon: Icons.settings,
      page: const Settings(),
    ),
  ];
}
