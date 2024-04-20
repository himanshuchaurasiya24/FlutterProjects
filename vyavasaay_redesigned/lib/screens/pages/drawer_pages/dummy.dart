import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vyavasaay_redesigned/database/database_helper.dart';
import 'package:vyavasaay_redesigned/model/doctor_model.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/custom_textfield.dart';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  Future<List<DoctorModel>> searchDoctor(String name) {
    if (name.trim().isEmpty) {
      return databaseHelper.getAllDoctorList();
    } else {
      return databaseHelper.searchDoctor(name: name);
    }
  }

  TextEditingController doctorSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: getDeviceHeight(context: context) * 0.8,
        width: getDeviceWidth(context: context) * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            defaultSize,
          ),
          color: primaryColorDark,
        ),
        child: ListView(
          children: [
            Gap(defaultSize),
            CustomTextField(
              maxLines: 1,
              onChanged: (p0) {
                setState(() {});
              },
              controller: doctorSearchController,
              hintText: 'Search here',
            ),
            SizedBox(
              height: getDeviceHeight(context: context) * 0.74,
              width: getDeviceWidth(context: context) * 0.8,
              child: FutureBuilder(
                future: databaseHelper.searchDoctor(
                    name: doctorSearchController.text),
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
                          'Empty Doctor List',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      );
                    }
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 6),
                          child: Card(
                            color: primaryColor,
                            elevation: 1,
                            child: Padding(
                              padding: EdgeInsets.all(defaultSize),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![index].name,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    snapshot.data![index].address,
                                  ),
                                ],
                              ),
                            ),
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
    );
  }
}
