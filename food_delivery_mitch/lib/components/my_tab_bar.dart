import 'package:flutter/material.dart';
import 'package:food_delivery_mitch/models/food_model.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    super.key,
    required this.tabController,
  });
  final TabController tabController;
  List<Tab> buildCatagoryTabs() {
    return FoodCatagory.values.map((catagory) {
      return Tab(
        text: catagory.toString().split('.').last,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        controller: tabController,
        tabs: buildCatagoryTabs(),
      ),
    );
  }
}
