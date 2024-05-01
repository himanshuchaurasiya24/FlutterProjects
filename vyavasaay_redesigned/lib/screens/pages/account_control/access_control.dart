import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/screens/pages/account_control/change_account_details.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(defaultSize),
                padding: EdgeInsets.all(defaultSize),
                decoration: BoxDecoration(
                  color: primaryCardColor,
                  borderRadius: BorderRadius.circular(defaultSize),
                ),
                child: Column(
                  children: [
                    Text(
                      'Admin Account List',
                      style: patientHeader,
                    ),
                    Gap(defaultSize),
                    Expanded(
                      child: FutureBuilder(
                        future: databaseHelper.getAllAdminAccount(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                              return Card(
                                color: primaryColor,
                                elevation: 0,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: defaultSize),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index].name,
                                            style: patientHeader,
                                          ),
                                          Text(
                                            snapshot.data![index].phoneNumber,
                                            style: patientHeaderSmall,
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return ChangeAccountDetails(
                                                  adminModel:
                                                      snapshot.data![index],
                                                );
                                              },
                                            ),
                                          ).then((value) => setState(() {}));
                                        },
                                        icon: const Icon(Icons.edit_outlined),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.all(defaultSize),
              padding: EdgeInsets.all(defaultSize),
              decoration: BoxDecoration(
                color: primaryCardColor,
                borderRadius: BorderRadius.circular(defaultSize),
              ),
              child: Column(
                children: [
                  Text(
                    'Technician Account List',
                    style: patientHeader,
                  ),
                  Gap(defaultSize),
                  Expanded(
                    child: FutureBuilder(
                      future: databaseHelper.getAllUserAccount(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                'Empty technician Account',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            );
                          }
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: primaryColor,
                              elevation: 0,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: defaultSize),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index].name,
                                          style: patientHeader,
                                        ),
                                        Text(
                                          snapshot.data![index].phoneNumber,
                                          style: patientHeaderSmall,
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return ChangeAccountDetails(
                                                userModel:
                                                    snapshot.data![index],
                                              );
                                            },
                                          ),
                                        ).then((value) {
                                          setState(() {});
                                        });
                                      },
                                      icon: const Icon(Icons.edit_outlined),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ))
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
