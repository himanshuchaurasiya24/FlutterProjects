import 'package:flutter/material.dart';
import 'package:vyawasaay/database/database_helper.dart';
import 'package:vyawasaay/models/doctor_model.dart';
import 'package:vyawasaay/screens/doctors/add_doctor_screen.dart';
import 'package:vyawasaay/widgets/custom_elevated_button.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  DatabaseHelper db = DatabaseHelper();
  late Future<List<DoctorModel>> doctorList;
  @override
  void initState() {
    doctorList = db.getDoctorsList();
    db.initDB().whenComplete(() {
      doctorList = db.getDoctorsList();
    });

    super.initState();
  }

  final DatabaseHelper database = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Doctors List',
        ),
        centerTitle: true,
      ),
      floatingActionButton: CustomElevatedButton(
        btnName: 'Add a doctor',
        function: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddDoctor();
              },
            ),
          ).then((value) {
            setState(() {});
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: database.getDoctorsList(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No Doctor Found in Database'),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.blue[40],
                      child: Column(
                        children: [
                          Text(snapshot.data![index].doctorName),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data![index].doctorAge,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapshot.data![index].doctorSex,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapshot.data![index].doctorPhoneNumber,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapshot.data![index].address,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            snapshot.data![index].incentivePercentage,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text('Null data to display'),
              );
            }
            return const Center(
              child: Text('Returning from last'),
            );
          },
        ),
      ),
    );
  }
}
