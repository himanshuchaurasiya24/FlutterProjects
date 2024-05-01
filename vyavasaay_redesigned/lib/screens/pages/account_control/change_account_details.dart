import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/model/admin_model.dart';
import 'package:vyavasaay_redesigned/model/user_model.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/container_button.dart';
import 'package:vyavasaay_redesigned/widgets/custom_textfield.dart';
import 'package:vyavasaay_redesigned/widgets/update_screen_widget.dart';

class ChangeAccountDetails extends StatefulWidget {
  const ChangeAccountDetails({super.key, this.adminModel, this.userModel});
  final AdminModel? adminModel;
  final UserModel? userModel;
  @override
  State<ChangeAccountDetails> createState() => _ChangeAccountDetailsState();
}

class _ChangeAccountDetailsState extends State<ChangeAccountDetails> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  bool changePassword = false;
  final databaseHelper = DatabaseHelper();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    databaseHelper.initDB();
    if (widget.adminModel != null) {
      name.text = widget.adminModel!.name;
      currentPassword.text = widget.adminModel!.password;
      phone.text = widget.adminModel!.phoneNumber;
    }
    if (widget.userModel != null) {
      name.text = widget.userModel!.name;
      currentPassword.text = widget.userModel!.password;
      phone.text = widget.userModel!.phoneNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text('Update Details'),
      ),
      body: UpdateScreenWidget(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: name,
                      hintText: 'Name',
                      readOnly: true,
                    ),
                  ),
                  Gap(defaultSize),
                  Expanded(
                    child: CustomTextField(
                      controller: phone,
                      hintText: 'Phone',
                    ),
                  ),
                  Gap(defaultSize),
                  Expanded(
                    child: CustomTextField(
                      controller: currentPassword,
                      hintText: 'Current Password',
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: !changePassword,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Want to change password?',
                      style: patientHeaderSmall,
                    ),
                    Gap(defaultSize),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          changePassword = !changePassword;
                        });
                      },
                      child: Text(
                        'Click Here',
                        style: patientChildrenHeading,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: changePassword,
                child: Column(
                  children: [
                    Gap(defaultSize),
                    CustomTextField(
                      controller: newPassword,
                      hintText: 'New Passsword',
                      maxLines: 1,
                    ),
                    Gap(defaultSize),
                    CustomTextField(
                      controller: confirmPassword,
                      isConfirm: true,
                      passwordController: newPassword,
                      hintText: 'Confirm Passsword',
                      maxLines: 1,
                    ),
                    Gap(defaultSize),
                    GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          if (widget.adminModel != null) {
                            await databaseHelper
                                .updateAdmin(
                              model: AdminModel(
                                id: widget.adminModel!.id,
                                name: name.text.toString(),
                                phoneNumber: phone.text,
                                password: confirmPassword.text.toString(),
                              ),
                            )
                                .then((value) {
                              Navigator.pop(context, value);
                            });
                          } else if (widget.userModel != null) {
                            await databaseHelper
                                .updateUser(
                              model: UserModel(
                                id: widget.userModel!.id,
                                name: name.text.toString(),
                                phoneNumber: phone.text,
                                password: confirmPassword.text.toString(),
                              ),
                            )
                                .then((value) {
                              Navigator.pop(context, value);
                            });
                          }
                        }
                      },
                      child: const ContainerButton(
                          iconData: Icons.update_outlined,
                          btnName: 'Update info'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
