import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/custom_details_card.dart';
import 'package:vyavasaay_redesigned/widgets/patient_details_child.dart';

class LoginHistory extends StatefulWidget {
  const LoginHistory({super.key});

  @override
  State<LoginHistory> createState() => _LoginHistoryState();
}

class _LoginHistoryState extends State<LoginHistory> {
  final databaseHelper = DatabaseHelper();
  @override
  void initState() {
    super.initState();
    databaseHelper.initDB();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Login History',
          style: appbar,
        ),
        Gap(defaultSize),
        Expanded(
          child: FutureBuilder(
            future: databaseHelper.getAllLoginHistory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Some error occurred',
                  ),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Empty data'),
                  );
                }
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return CustomDetailsCard(
                    title: snapshot.data![index].name,
                    subtitle: Text(
                      'Login at ${snapshot.data![index].loginTime}',
                      style: patientHeaderSmall,
                    ),
                    trailing: snapshot.data![index].type,
                    children: [
                      PatientDetailsChild(
                        heading: 'Person Id ',
                        value: snapshot.data![index].personId.toString(),
                      ),
                      PatientDetailsChild(
                        heading: 'Logout at ',
                        value: snapshot.data![index].logoutTime.toString(),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
