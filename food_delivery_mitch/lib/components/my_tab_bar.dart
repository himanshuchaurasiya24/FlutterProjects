import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    super.key,
    required this.tabController,
  });
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(controller: tabController, tabs: const [
        Tab(
          icon: Icon(
            Icons.home_rounded,
            size: 16,
          ),
        ),
        Tab(
          icon: Icon(
            Icons.settings_rounded,
            size: 16,
          ),
        ),
        Tab(
          icon: Icon(
            Icons.person_rounded,
            size: 16,
          ),
        ),
      ]),
    );
  }
}
