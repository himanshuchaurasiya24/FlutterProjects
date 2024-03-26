import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vyavasaay_redesigned/screens/model/menu_items.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.name, required this.logInType});
  final String name;
  final String logInType;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final adminMenuItems = MenuItems().adminMenuItems;
  final userMenuItems = MenuItems().usersMenuItems;
  int currentIndex = 0;
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorDark,
      body: Row(
        children: [
          background(
            child: Column(
              children: [
                widget.logInType == 'admin'
                    ? Center(
                        child: Icon(
                          Icons.admin_panel_settings_outlined,
                          color: titleLargeTextColor,
                          size: 200,
                        ),
                      )
                    : Center(
                        child: Icon(
                          Icons.person_outlined,
                          color: primaryColorDark,
                        ),
                      ),
                Text(
                  widget.logInType == 'admin'
                      ? '${widget.name}\n(${widget.logInType})'
                      : '${widget.name}\n(${widget.logInType})',
                  style: TextStyle(
                    color: titleLargeTextColor,
                    fontSize: defaultSize,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      isSelected = currentIndex == index;
                      return Container(
                        margin: EdgeInsets.only(
                          top: index == 0 ? 2 : 0,
                          bottom: 4,
                          left: 3,
                          right: 3,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? titleLargeTextColor
                              : primaryColorDark,
                          borderRadius: BorderRadius.circular(
                            defaultSize - 10,
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          leading: Icon(
                            widget.logInType == 'admin'
                                ? adminMenuItems[index].icon
                                : userMenuItems[index].icon,
                          ),
                          title: Text(
                            widget.logInType == 'admin'
                                ? adminMenuItems[index].title
                                : userMenuItems[index].title,
                            style: TextStyle(
                              color: currentIndex == index
                                  ? primaryColorDark
                                  : titleLargeTextColor,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: widget.logInType == 'admin'
                        ? adminMenuItems.length
                        : userMenuItems.length,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: background(
              width: double.infinity,
              rightMargin: defaultSize,
              child: PageView.builder(
                itemCount: widget.logInType == 'admin'
                    ? adminMenuItems.length
                    : userMenuItems.length,
                itemBuilder: (context, index) {
                  return widget.logInType == 'admin'
                      ? adminMenuItems[currentIndex].child
                      : userMenuItems[currentIndex].child;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget background({
    double? width,
    double? rightMargin,
    required Widget child,
  }) {
    return Container(
      height: double.infinity,
      width: width ?? 230,
      margin: EdgeInsets.only(
        left: defaultSize,
        top: defaultSize,
        bottom: defaultSize,
        right: rightMargin ?? 0,
      ),
      padding: const EdgeInsets.all(
        3,
      ),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(
          defaultSize,
        ),
      ),
      child: child,
    );
  }
}
