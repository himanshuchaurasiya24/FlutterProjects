import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/screens/pages/account_control/create_account.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/default_container.dart';

class AccessControl extends StatefulWidget {
  const AccessControl({super.key});

  @override
  State<AccessControl> createState() => _AccessControlState();
}

class _AccessControlState extends State<AccessControl> {
  @override
  void initState() {
    super.initState();
    databaseHelper.initDB();
  }

  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Text(
              'Admin Account List',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Gap(defaultSize),
            Expanded(
              child: FutureBuilder(
                future: databaseHelper.getAllAdminAccount(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Some error occurred!',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'Empty Admin Account',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      );
                    }
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          snapshot.data![index].name,
                        ),
                        subtitle: Text(snapshot.data![index].name),
                      );
                    },
                  );
                },
              ),
            ),
            Gap(defaultSize),
            Text(
              'Technician Account List',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Gap(defaultSize),
            Expanded(
              child: FutureBuilder(
                future: databaseHelper.getAllUserAccount(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Some error occurred!',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'Empty User Account',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      );
                    }
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          snapshot.data![index].name,
                        ),
                        subtitle: Text(snapshot.data![index].name),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 10,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const CreateAccount();
                  },
                ),
              ).then(
                (value) {
                  if (value != 0) {
                    setState(() {});
                  }
                },
              );
            },
            child: DefaultContainer(
              height: MediaQuery.of(context).size.height * 0.1,
              width: 260,
              boxShadow: [
                BoxShadow(
                  color: primaryColorDark,
                  blurStyle: BlurStyle.outer,
                  blurRadius: 50,
                  spreadRadius: 0.5,
                ),
              ],
              child: Center(
                child: Text(
                  'Create account',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 28,
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
