import 'dart:developer';

import 'package:devmensit_mongo_db/dbHelper/constant.dart';
import 'package:devmensit_mongo_db/mongodb_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<void> update(MongoDbModel model) async {
    var result = await userCollection.findOne({
      '_id': model.id,
    });
    result['firstName'] = model.firstName;
    result['lastName'] = model.lastName;
    result['address'] = model.address;
    var response = await userCollection.save(result);
    inspect(response);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  static Future<String> insert(MongoDbModel model) async {
    try {
      var result = await userCollection.insertOne(
        model.toJson(),
      );
      if (result.isSuccess) {
        print('data insrted');
        return 'Data inserted';
      } else {
        print('somthing wrong');
        return 'Something wrong happened..';
      }
    } catch (e) {
      print(
        e.toString(),
      );
      return e.toString();
    }
  }
}
