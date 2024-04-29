import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:vyavasaay_redesigned/model/admin_model.dart';
import 'package:vyavasaay_redesigned/model/user_model.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/custom_textfield.dart';

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
  final password = TextEditingController();
  final cPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Details'),
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
                Expanded(
                  child: CustomTextField(
                    controller: phone,
                    hintText: 'Phone',
                  ),
                ),
              ],
            ),
            Gap(defaultSize),
            CustomTextField(
              controller: currentPassword,
              hintText: 'Current Passsword',
              readOnly: true,
            ),
            Visibility(
              child: Gap(defaultSize),
            ),
            Visibility(
              child: CustomTextField(
                controller: password,
                hintText: 'New Passsword',
              ),
            ),
            Visibility(
              child: Gap(defaultSize),
            ),
            Visibility(
              child: CustomTextField(
                controller: cPassword,
                hintText: 'Confirm Passsword',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
