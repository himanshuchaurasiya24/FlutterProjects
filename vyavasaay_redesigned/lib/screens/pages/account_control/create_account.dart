import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/model/admin_model.dart';
import 'package:vyavasaay_redesigned/model/user_model.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/custom_textfield.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final name = TextEditingController();

  final phone = TextEditingController();

  final password = TextEditingController();

  final cPassword = TextEditingController();
  bool isAdminAccount = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  void initState() {
    super.initState();
    databaseHelper.initDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Container(
        margin: EdgeInsets.all(defaultSize * 3),
        height: getDeviceHeight(context: context),
        width: getDeviceWidth(context: context),
        padding: EdgeInsets.all(defaultSize),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            defaultSize,
          ),
          color: primaryColorDark,
        ),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: name,
                        hintText: 'Name',
                      ),
                    ),
                    Gap(defaultSize),
                    Container(
                      height: 58,
                      width: getDeviceWidth(context: context) * 0.2,
                      decoration: BoxDecoration(
                        color: primaryColor,
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
                            hoverColor: primaryColorDarker,
                            activeColor: titleLargeTextColor,
                            value: isAdminAccount,
                            onChanged: (value) {
                              setState(() {
                                isAdminAccount = !isAdminAccount;
                              });
                            },
                          ),
                          SizedBox(
                            width: defaultSize,
                          ),
                          Text(
                            'Create as Admin Account',
                            style: TextStyle(
                              color: titleLargeTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(defaultSize),
                CustomTextField(
                  controller: phone,
                  hintText: 'Phone Number',
                ),
                Gap(defaultSize),
                CustomTextField(
                  controller: password,
                  isObscure: true,
                  hintText: 'Password',
                ),
                Gap(defaultSize),
                CustomTextField(
                  controller: cPassword,
                  isConfirm: true,
                  isObscure: true,
                  hintText: 'Confirm Password',
                  passwordController: password,
                ),
                Gap(defaultSize),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      if (isAdminAccount) {
                        await databaseHelper
                            .createAdminAccount(
                          model: AdminModel(
                            name: name.text,
                            phoneNumber: phone.text,
                            password: password.text,
                          ),
                        )
                            .then((value) {
                          Navigator.pop(context, value);
                        }).onError((error, stackTrace) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(error.toString()),
                              );
                            },
                          );
                        });
                      } else {
                        await databaseHelper
                            .createUserAccount(
                          model: UserModel(
                            name: name.text,
                            phoneNumber: phone.text,
                            password: password.text,
                          ),
                        )
                            .then((value) {
                          Navigator.pop(context, value);
                        }).onError((error, stackTrace) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(error.toString()),
                              );
                            },
                          );
                        });
                      }
                    }
                  },
                  child: Container(
                    height: getDeviceHeight(context: context) * 0.1,
                    width: getDeviceWidth(context: context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultSize),
                      color: primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
