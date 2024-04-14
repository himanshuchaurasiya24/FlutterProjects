import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_mitch/components/constants.dart';
import 'package:food_delivery_mitch/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings Page',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  defaultPadding,
                ),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Dark Mode'),
                  CupertinoSwitch(
                    value: Provider.of<ThemeProvider>(context, listen: false)
                        .isDark,
                    onChanged: (value) {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
