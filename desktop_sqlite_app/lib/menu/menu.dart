import 'package:desktop_sqlite_app/components/colors.dart';
import 'package:desktop_sqlite_app/menu/menu_items.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final menuList = MenuItems();
  int currentIndex = 0;
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          background(
            Column(
              children: [
                Image.asset('assets/zaitoon.png'),
                Expanded(
                  flex: 3,
                  child: ListView.builder(
                    itemCount: menuList.items.length,
                    itemBuilder: (context, index) {
                      isSelected = currentIndex == index;
                      return Container(
                        margin: const EdgeInsetsDirectional.symmetric(
                          vertical: 2,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? primaryColor.withOpacity(0.3)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          leading: Icon(
                            menuList.items[index].icon,
                          ),
                          title: Text(
                            menuList.items[index].title,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Log Out'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: PageView.builder(
              itemCount: menuList.items.length,
              itemBuilder: (context, index) {
                return menuList.items[currentIndex].page;
              },
            ),
          ))
        ],
      ),
    );
  }

  Widget background(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      height: double.infinity,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              blurRadius: 1,
              spreadRadius: 0),
        ],
      ),
      child: child,
    );
  }
}
