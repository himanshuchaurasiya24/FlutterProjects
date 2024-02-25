import 'package:flutter/material.dart';
import 'package:zaitoon_db_remember/component/colors.dart';
import 'package:zaitoon_db_remember/json/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.model});
  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: backgroundColor,
              radius: 67,
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/no_user.jpg'),
                radius: 55,
              ),
            ),
            Text(
              model.fullName!,
              style: TextStyle(
                color: primaryColor,
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              model.email!,
              style: TextStyle(
                fontSize: 17,
                color: primaryColor,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(model.fullName!),
              subtitle: const Text('Full Name'),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(model.email!),
              subtitle: const Text('Email'),
            ),
            ListTile(
              leading: const Icon(Icons.person_2),
              title: Text(model.userName),
              subtitle: const Text('Username'),
            ),
          ],
        ),
      )),
    );
  }
}
