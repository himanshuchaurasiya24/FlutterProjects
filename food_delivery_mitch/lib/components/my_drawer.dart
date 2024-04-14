import 'package:flutter/material.dart';
import 'package:food_delivery_mitch/components/my_drawer_tile.dart';
import 'package:food_delivery_mitch/pages/login_page.dart';
import 'package:food_delivery_mitch/pages/settings_page.dart';
import 'package:gap/gap.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      // shape: BeveledRectangleBorder(
      //   borderRadius: BorderRadius.circular(
      //     defaultPadding,
      //   ),
      // ),
      // shape: ContinuousRectangleBorder(
      //   borderRadius: BorderRadius.circular(defaultPadding * 3),
      // ),
      child: Column(
        children: [
          const Gap(50),
          const Icon(
            Icons.lock_open_rounded,
            size: 80,
          ),
          const Gap(10),
          Divider(
            indent: 10,
            endIndent: 10,
            thickness: 1.5,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          const Gap(10),
          MyDrawerTile(
            text: 'Home',
            icon: Icons.home_outlined,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Gap(5),
          MyDrawerTile(
            text: 'Settings',
            icon: Icons.settings_outlined,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SettingsPage();
                  },
                ),
              );
            },
          ),
          const Spacer(),
          const Gap(5),
          MyDrawerTile(
            text: 'Log Out',
            icon: Icons.logout_outlined,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
