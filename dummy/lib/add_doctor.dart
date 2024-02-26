// import 'package:dummy/data_model.dart';
// import 'package:dummy/database_helper.dart';
// import 'package:flutter/material.dart';

// class AddPerson extends StatefulWidget {
//   const AddPerson({super.key});

//   @override
//   State<AddPerson> createState() => _AppPersonState();
// }
// //
// class _AppPersonState extends State<AddPerson> {
//   final DatabaseHelper db = DatabaseHelper();
//   final nameController = TextEditingController();
//   final phoneNumberController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Person'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 labelText: 'Enter Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             TextField(
//               controller: phoneNumberController,
//               decoration: const InputDecoration(
//                 labelText: 'Enter Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             ElevatedButton(
//                 onPressed: () async {
//                   await db.insertPeronModel(
//                     model: PersonModel(
//                       name: nameController.text,
//                       phoneNumber: int.parse(
//                         phoneNumberController.text,
//                       ),
//                     ),
//                   );
//                 },
//                 child: const Text('Add Person'))
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:dummy/model/data_model.dart';
import 'package:dummy/database/database_helper.dart';
import 'package:flutter/material.dart';

class AddDoctor extends StatelessWidget {
  AddDoctor({super.key});
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final incentiveController = TextEditingController();
  final db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Doctor'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CustomTextForm(
            nameController: nameController,
            hintText: 'Name',
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextForm(
            nameController: addressController,
            hintText: 'Address',
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextForm(
            nameController: phoneNumberController,
            hintText: 'Phone Number',
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextForm(
            nameController: incentiveController,
            hintText: 'Incentive',
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isEmpty ||
                  phoneNumberController.text.isEmpty ||
                  addressController.text.isEmpty ||
                  incentiveController.text.isEmpty) {
                return;
              } else {
                await db
                    .insertDoctorModel(
                      model: DoctorModel(
                        name: nameController.text,
                        address: addressController.text,
                        phoneNumber: phoneNumberController.text,
                        incentive: int.parse(
                          incentiveController.text,
                        ),
                      ),
                    )
                    .then(
                      (value) => Navigator.pop(context),
                    );
              }
            },
            child: const Text('Add Doctor'),
          ),
        ],
      ),
    );
  }
}

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    required this.nameController,
    required this.hintText,
  });

  final TextEditingController nameController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
      ),
    );
  }
}
