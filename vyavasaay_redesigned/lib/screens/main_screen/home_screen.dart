import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/default_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.name,
    required this.logInType,
  });
  final String name;
  final String logInType;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget.logInType);
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 30,
      //   forceMaterialTransparency: true,
      //   title: Text(
      //     '${widget.name} (${widget.logInType})',
      //     style: TextStyle(
      //       color: titleLargeTextColor,
      //       fontSize: titleLargeTextSize - 20,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       onPressed: () async {
      //         SharedPreferences prefs = await SharedPreferences.getInstance();
      //         prefs.setBool('isLoggedIn', false);
      //         prefs.setString('logInType', 'user');
      //         prefs.setString('loggedInName', ' ');
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) {
      //               return const LoginScreen();
      //             },
      //           ),
      //         );
      //       },
      //       icon: const Icon(
      //         Icons.logout_outlined,
      //       ),
      //     ),
      //   ],
      // ),
      backgroundColor: primaryColorDark,
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: DefaultContainer(
                  color: primaryColor,
                  height: getDeviceHeight(context: context) * 0.94,
                  // width: getDeviceWidth(context: context) * 0.20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: defaultSize - 10,
                      ),
                      CircleAvatar(
                        radius: 64,
                        child: widget.logInType == 'admin'
                            ? const Icon(
                                Icons.shield,
                                size: 64,
                              )
                            : const Icon(
                                Icons.person,
                                size: 64,
                              ),
                      ),
                      Text(
                        '${widget.name}\n(${widget.logInType})',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: defaultSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: DefaultContainer(
                  height: getDeviceHeight(context: context) * 0.94,
                  color: primaryColor,
                  // width: getDeviceWidth(context: context) * 0.6,
                  child: const Center(child: Text('data')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
