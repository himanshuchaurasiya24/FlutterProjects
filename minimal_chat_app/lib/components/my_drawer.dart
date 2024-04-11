import 'package:flutter/material.dart';
import 'package:minimal_chat_app/services/auth/auth_service.dart';
import 'package:minimal_chat_app/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const DrawerHeader(
                  child: Center(
                    child: Icon(
                      Icons.message_outlined,
                      size: 64,
                      color: Colors.black,
                    ),
                  ),
                ),
                MyDrawerListTile(
                  text: 'Home',
                  icon: Icons.home_outlined,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                MyDrawerListTile(
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
              ],
            ),
            MyDrawerListTile(
              text: 'Log Out',
              icon: Icons.logout_outlined,
              onTap: () {
                Navigator.pop(context);
                AuthService().logOut();
              },
            )
          ],
        ),
      ),
    );
  }
}

class MyDrawerListTile extends StatelessWidget {
  const MyDrawerListTile({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });
  final String text;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(
          letterSpacing: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}
