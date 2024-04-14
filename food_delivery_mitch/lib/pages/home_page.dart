import 'package:flutter/material.dart';
import 'package:food_delivery_mitch/components/constants.dart';
import 'package:food_delivery_mitch/components/my_current_location.dart';
import 'package:food_delivery_mitch/components/my_description_box.dart';
import 'package:food_delivery_mitch/components/my_drawer.dart';
import 'package:food_delivery_mitch/components/my_sliver_appbar.dart';
import 'package:food_delivery_mitch/components/my_tab_bar.dart';
import 'package:food_delivery_mitch/components/my_textformfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  final TextEditingController locationController = TextEditingController();
  final GlobalKey<FormState> _locationSearchKey = GlobalKey<FormState>();
  void openLocationSearchBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Your Location'),
          content: Form(
            key: _locationSearchKey,
            child: MyTextformfield(
              hintText: 'Enter your address',
              controller: locationController,
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                if (_locationSearchKey.currentState!.validate()) {
                  //to save
                }
              },
              child: const Text('Save'),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            MySliverAppbar(
              title: MyTabBar(tabController: tabController),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Divider(
                    indent: defaultPadding,
                    endIndent: defaultPadding,
                    thickness: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  GestureDetector(
                      onTap: () {
                        openLocationSearchBox(context);
                      },
                      child: const MyCurrentLocation()),
                  const MyDescriptionBox(),
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: [
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Text('First Tab Items');
              },
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Text('Second Tab Items');
              },
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Text('Third Tab Items');
              },
            ),
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
