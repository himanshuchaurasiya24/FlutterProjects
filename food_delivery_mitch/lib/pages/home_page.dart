import 'package:flutter/material.dart';
import 'package:food_delivery_mitch/components/my_drawer.dart';
import 'package:food_delivery_mitch/components/my_sliver_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const MySliverAppbar(
              title: Text('title2'),
              child: Text('title'),
            )
          ];
        },
        body: Container(
          color: Colors.blue,
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
