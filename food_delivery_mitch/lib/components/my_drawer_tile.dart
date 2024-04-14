import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {
  const MyDrawerTile({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });
  final String text;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              letterSpacing: 10,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
      ),
      leading: Icon(
        icon,
        color: Theme.of(context).iconTheme.color,
        size: 32,
      ),
    );
  }
}
