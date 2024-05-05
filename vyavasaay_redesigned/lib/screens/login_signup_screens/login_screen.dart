import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/model/login_history_model.dart';
import 'package:vyavasaay_redesigned/screens/main_screen/home_screen.dart';
import 'package:vyavasaay_redesigned/screens/login_signup_screens/signup_screen.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/container_button.dart';
import 'package:vyavasaay_redesigned/widgets/custom_textfield.dart';
import 'package:vyavasaay_redesigned/widgets/update_screen_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  DatabaseHelper database = DatabaseHelper();
  Color containerColor = primaryColorLite;
  bool isAdminLogin = false;
  @override
  void initState() {
    super.initState();
  }

  void showBanner(BuildContext context) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        backgroundColor: primaryColorDark,
        dividerColor: primaryColorDark,
        contentTextStyle: TextStyle(
          fontSize: defaultSize,
          fontWeight: FontWeight.w600,
        ),
        forceActionsBelow: false,
        overflowAlignment: OverflowBarAlignment.end,
        content: const Text(
          'No Account Found.',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).clearMaterialBanners();
            },
            icon: Text(
              'Okay',
              style: TextStyle(
                fontSize: defaultSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void logIn(
      {required String name,
      required String type,
      required int personId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    prefs.setString('loggedInName', name);
    prefs.setString('logInType', type);
    prefs.setInt('personId', personId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpdateScreenWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/login_signup.png',
            ),
            Form(
              key: _formKey,
              child: Expanded(
                child: Padding(
                  padding: EdgeInsets.all(defaultSize),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Log In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: titleLargeTextSize,
                          ),
                        ),
                        SizedBox(
                          height: defaultSize,
                        ),
                        CustomTextField(
                          controller: nameController,
                          hintText: 'Name',
                        ),
                        SizedBox(
                          height: defaultSize,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          isObscure: true,
                        ),
                        SizedBox(
                          height: defaultSize,
                        ),
                        Container(
                          height: 58,
                          width: getDeviceWidth(context: context) * 0.2,
                          decoration: BoxDecoration(
                            color: primaryColorDark,
                            borderRadius: BorderRadius.circular(
                              defaultSize,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: defaultSize / 2,
                              ),
                              Checkbox.adaptive(
                                value: isAdminLogin,
                                onChanged: (value) {
                                  setState(() {
                                    isAdminLogin = !isAdminLogin;
                                  });
                                },
                              ),
                              SizedBox(
                                width: defaultSize,
                              ),
                              const Text(
                                'Admin Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: defaultSize,
                        ),
                        InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              isAdminLogin
                                  ? await database
                                      .authAdmin(
                                          name:
                                              nameController.text.toUpperCase(),
                                          password: passwordController.text)
                                      .then((value) async {
                                      if (value == true) {
                                        final model = await database.getAdmin(
                                            name: nameController.text
                                                .toUpperCase());
                                        final name = model!.name;
                                        final personalId = model.id;
                                        logIn(
                                            name: name,
                                            type: 'Admin',
                                            personId: personalId!);
                                        await database
                                            .addToLoginHistory(
                                              model: LoginHistoryModel(
                                                personId: personalId,
                                                name: name,
                                                loginTime: DateFormat(
                                                        'dd MMMM yyyy hh:mm:s a')
                                                    .format(DateTime.now()),
                                                logoutTime:
                                                    'Currently logged in',
                                                type: 'Admin',
                                              ),
                                            )
                                            .then((value) =>
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return HomeScreen(
                                                        name: name,
                                                        logInType: 'Admin',
                                                      );
                                                    },
                                                  ),
                                                ));
                                      } else {
                                        showBanner(context);
                                      }
                                    })
                                  : await database
                                      .authUser(
                                          name:
                                              nameController.text.toUpperCase(),
                                          password: passwordController.text)
                                      .then((value) async {
                                      if (value == true) {
                                        final model = await database.getUser(
                                            name: nameController.text
                                                .toUpperCase());
                                        final name = model!.name;
                                        int personalId = model.id!;
                                        logIn(
                                            name: name,
                                            type: 'Technician',
                                            personId: personalId);
                                        await database
                                            .addToLoginHistory(
                                              model: LoginHistoryModel(
                                                personId: personalId,
                                                name: name,
                                                loginTime: DateFormat(
                                                        'dd MMMM yyyy hh:mm:s a')
                                                    .format(DateTime.now()),
                                                logoutTime:
                                                    'Currently logged in',
                                                type: 'Technician',
                                              ),
                                            )
                                            .then((value) =>
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return HomeScreen(
                                                        name: name,
                                                        logInType: 'Technician',
                                                      );
                                                    },
                                                  ),
                                                ));
                                      } else {
                                        showBanner(context);
                                      }
                                    });
                            }
                          },
                          child: const ContainerButton(
                              iconData: Icons.login_outlined, btnName: 'Login'),
                        ),
                        SizedBox(
                          height: defaultSize,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: SizedBox(),
                                  ),
                                  const Text(
                                    'Don\'t have an account?',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const SignUpScreen();
                                          },
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Sign up instead',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    child: SizedBox(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
