import 'package:flutter/material.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/screens/login_signup_screens/login_screen.dart';
import 'package:vyavasaay_redesigned/model/admin_model.dart';

import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/container_button.dart';
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
  Color containerColor = primaryColorLite;
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
        backgroundColor: primaryColorLite,
        dividerColor: primaryColorLite,
        contentTextStyle: TextStyle(
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
                            child: const ContainerButton(
                                iconData: Icons.check_circle_outline_outlined,
                                btnName: 'Sign up')),
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
                                    'Already have an account?',
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
                                            return const LoginScreen();
                                          },
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Log in instead',
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
