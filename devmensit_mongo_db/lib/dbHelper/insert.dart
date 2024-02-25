import 'package:devmensit_mongo_db/dbHelper/mongodb.dart';
import 'package:devmensit_mongo_db/mongodb_model.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({super.key});

  @override
  State<MongoDbInsert> createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {
  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _addressNameController = TextEditingController();
  final _idController = TextEditingController();
  var _checkInsertUpdate = 'Insert';
  @override
  Widget build(BuildContext context) {
    MongoDbModel data =
        ModalRoute.of(context)!.settings.arguments as MongoDbModel;
    if (data != null) {
      _fNameController.text = data.firstName;
      _lNameController.text = data.lastName;
      _addressNameController.text = data.address;

      _checkInsertUpdate = 'Update';
      if (_checkInsertUpdate == 'Update') {
        _idController.text = data.id.toString();
      }
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              _checkInsertUpdate,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 50,
            ),
            _checkInsertUpdate == 'Update'
                ? TextField(
                    controller: _idController,
                  )
                : const SizedBox(
                    height: 10,
                  ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _fNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _lNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _addressNameController,
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    _fakeData();
                  },
                  child: const Text('Generate Data'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_checkInsertUpdate == 'Update') {
                      _updateData(data.id, _fNameController.text,
                          _lNameController.text, _addressNameController.text);
                    } else {
                      _insertData(_fNameController.text, _lNameController.text,
                          _addressNameController.text);
                    }
                  },
                  child: Text(_checkInsertUpdate),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _insertData(String fname, String lName, String address) async {
    var _id = M.ObjectId();
    final data = MongoDbModel(
      firstName: fname,
      lastName: lName,
      address: address,
      id: _id,
    );
    var result = MongoDatabase.insert(data);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('result is $result and inserted id ${_id.$oid}')));
    clearAll();
  }

  Future<void> _updateData(
      var id, String fName, String lName, String address) async {
    final updateData = MongoDbModel(
      id: id,
      firstName: fName,
      lastName: lName,
      address: address,
    );
    await MongoDatabase.update(updateData).whenComplete(
      () => Navigator.pop(context),
    );
  }

  void clearAll() {
    _fNameController.text = '';
    _lNameController.text = '';

    _addressNameController.text = '';
  }

  void _fakeData() {
    setState(() {
      _fNameController.text = faker.person.firstName();
      _lNameController.text = faker.person.lastName();
      _addressNameController.text =
          '${faker.address.streetName()}\n${faker.address.streetAddress()}';
    });
  }
}
