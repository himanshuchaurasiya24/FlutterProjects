import 'package:flutter/material.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/screens/login_signup_screens/login_screen.dart';
import 'package:vyavasaay_redesigned/model/admin_model.dart';

import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/custom_textfield.dart';
import 'package:vyavasaay_redesigned/widgets/default_container.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  Color containerColor = primaryColor;
  DatabaseHelper database = DatabaseHelper();
  late Future<List<AdminModel>> adminList;
  late int adminAccountLength;
  @override
  void initState() {
    adminList = database.getAllAdminAccount();
    database.initDB().whenComplete(() async {
      adminList = database.getAllAdminAccount();
      adminAccountLength = await database.getAdminAccountLength();
    });
    super.initState();
  }

  void showBanner(BuildContext context) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        padding: EdgeInsets.only(
          left: defaultSize + 10,
          right: defaultSize - 10,
        ),
        backgroundColor: primaryColor,
        dividerColor: primaryColor,
        contentTextStyle: TextStyle(
          color: titleLargeTextColor,
          fontSize: defaultSize,
          fontWeight: FontWeight.w600,
        ),
        forceActionsBelow: false,
        overflowAlignment: OverflowBarAlignment.end,
        content: const Text(
          'An Admin Account is Already Created.\nContact Admin For Your Account Creation.',
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).clearMaterialBanners();
            },
            icon: Text(
              'Okay',
              style: TextStyle(
                color: titleLargeTextColor,
                fontSize: defaultSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultContainer(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: titleLargeTextSize,
                            color: titleLargeTextColor,
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
                          isObscure: true,
                          hintText: 'Password',
                        ),
                        SizedBox(
                          height: defaultSize,
                        ),
                        CustomTextField(
                          controller: confirmPasswordController,
                          isObscure: true,
                          isConfirm: true,
                          passwordController: passwordController,
                          hintText: 'Confirm Password',
                        ),
                        SizedBox(
                          height: defaultSize,
                        ),
                        CustomTextField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          hintText: 'Phone Number',
                        ),
                        SizedBox(
                          height: defaultSize,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              if (adminAccountLength > 0) {
                                showBanner(context);
                                return;
                              } else {
                                await database
                                    .createAdminAccount(
                                      model: AdminModel(
                                        name: nameController.text,
                                        phoneNumber: phoneController.text,
                                        password: passwordController.text,
                                      ),
                                    )
                                    .then(
                                      (value) => {
                                        if (value != 0)
                                          {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return const SignUpScreen();
                                                },
                                              ),
                                            ),
                                          }
                                        else
                                          {showBanner(context)}
                                      },
                                    );
                              }
                            }
                          },
                          child: MouseRegion(
                            onEnter: (event) {
                              setState(() {
                                containerColor = primaryColorDarker;
                              });
                            },
                            onExit: (event) {
                              setState(() {
                                containerColor = primaryColor;
                              });
                            },
                            child: Container(
                              height: getDeviceHeight(context: context) * 0.1,
                              width: getDeviceWidth(context: context) * 0.55,
                              decoration: BoxDecoration(
                                color: containerColor,
                                borderRadius: BorderRadius.circular(
                                  defaultSize,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: titleLargeTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: titleLargeTextSize - 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                                  Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                      color: titleLargeTextColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const LoginScreen();
                                          },
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Log in instead',
                                      style: TextStyle(
                                        color: titleLargeTextColor,
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
