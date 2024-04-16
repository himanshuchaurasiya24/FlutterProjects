import 'package:flutter/material.dart';
import 'package:food_delivery_mitch/components/constants.dart';
import 'package:food_delivery_mitch/components/my_current_location.dart';
import 'package:food_delivery_mitch/components/my_description_box.dart';
import 'package:food_delivery_mitch/components/my_drawer.dart';
import 'package:food_delivery_mitch/components/my_sliver_appbar.dart';
import 'package:food_delivery_mitch/components/my_tab_bar.dart';
import 'package:food_delivery_mitch/components/my_textformfield.dart';
import 'package:food_delivery_mitch/models/food_model.dart';
import 'package:food_delivery_mitch/models/resturant_model.dart';
import 'package:food_delivery_mitch/components/my_food_tile.dart';
import 'package:food_delivery_mitch/pages/food_page.dart';
import 'package:provider/provider.dart';

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
    tabController =
        TabController(length: FoodCatagory.values.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  List<FoodModel> filterByMenu(
      {required FoodCatagory catagory, required List<FoodModel> fullMenu}) {
    return fullMenu.where((food) => food.catagory == catagory).toList();
  }

  List<Widget> getFoodInThisCatagory({required List<FoodModel> fullMenu}) {
    return FoodCatagory.values.map(
      (catagory) {
        List<FoodModel> catagoryMenu =
            filterByMenu(catagory: catagory, fullMenu: fullMenu);
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: catagoryMenu.length,
          itemBuilder: (context, index) {
            return MyFoodTile(
              model: catagoryMenu[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return FoodPage(model: catagoryMenu[index]);
                    },
                  ),
                );
              },
            );
          },
        );
      },
    ).toList();
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
        body: Consumer<Resturant>(
          builder: (context, resturant, child) {
            return TabBarView(
              controller: tabController,
              children: getFoodInThisCatagory(fullMenu: resturant.menu),
            );
          },
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
