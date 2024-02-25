import 'package:flutter/material.dart';
import 'package:tms/screen/profile_page.dart';

import 'package:tms/widgets/constants.dart';
import 'package:tms/widgets/premium.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomePage(),
      const ProfilePage(),
    ];
    return Scaffold(
      // bottomNavigationBar: ,
      appBar: _buildAppBar(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 5)
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            backgroundColor: kwhite,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded), label: 'Person'),
            ],
            onTap: (index) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kdark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.add,
          color: klgihtgrey,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: pages[activeIndex],
    );
  }
}

AppBar _buildAppBar() {
  return AppBar(
    backgroundColor: kwhite,
    elevation: 0,
    title: Row(
      children: [
        Container(
          height: 45,
          width: 45,
          margin: const EdgeInsets.only(left: 10, top: 5),
          decoration: BoxDecoration(
            color: klgihtgrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/profile.jpg'),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          'Hello Himanshu!',
          style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 23,
              fontWeight: FontWeight.bold),
        )
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.more_vert,
          color: Colors.grey.shade600,
          size: 40,
        ),
      ),
    ],
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 25.0,
            right: 25.0,
            top: 10,
          ),
          child: GoPremium(),
        ),
      ],
    );
  }
}
