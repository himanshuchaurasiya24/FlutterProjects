import 'package:dummy_center/database/database_helper.dart';
import 'package:dummy_center/models/doctor_model.dart';
import 'package:dummy_center/screens/doctor/add_doctor.dart';
import 'package:flutter/material.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  DatabaseHelper db = DatabaseHelper();
  late Future<List<DoctorModel>> doctorList;

  @override
  void initState() {
    doctorList = db.getDoctorModel();
    db.initDB().whenComplete(() {
      doctorList = db.getDoctorModel();
    });
    super.initState();
  }

  // Future<List<DoctorModel>> getDoctorList() {
  //   return db.getDoctorModel();
  // }

  // Future<List<DoctorModel>> searchDoctor() {
  //   return db.searchDoctorModel(doctorName: searchController.text);
  // }

  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors List'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddDoctor();
              },
            ),
          );
        },
        label: const Text('Add Doctor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      doctorList = db.searchDoctorModel(
                          doctorName: searchController.text);
                    });
                  } else {
                    setState(() {
                      doctorList = db.getDoctorModel();
                    });
                  }
                },
                decoration: const InputDecoration(
                    hintText: 'Search here',
                    icon: Icon(Icons.search),
                    border: InputBorder.none),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<DoctorModel>>(
                future: doctorList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: Text('Null data for display'),
                      );
                    }
                    if (snapshot.data != null) {
                      if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No data to display'),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data![index].id.toString(),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(snapshot.data![index].name),
                                  Text(snapshot.data![index].address),
                                  Text(snapshot.data![index].phoneNumber),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    }
                  }
                  return const Text('Returning from last');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
