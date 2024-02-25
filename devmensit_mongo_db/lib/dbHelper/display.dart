import 'package:devmensit_mongo_db/dbHelper/mongodb.dart';
import 'package:devmensit_mongo_db/mongodb_model.dart';
import 'package:flutter/material.dart';

class DisplayMongoDb extends StatelessWidget {
  const DisplayMongoDb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Data'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Text('Hello world'),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder(
              future: MongoDatabase.getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              Text(
                                MongoDbModel.fromJson(snapshot.data![index])
                                    .id
                                    .toString(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                MongoDbModel.fromJson(snapshot.data![index])
                                    .firstName
                                    .toString(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                MongoDbModel.fromJson(snapshot.data![index])
                                    .lastName
                                    .toString(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                MongoDbModel.fromJson(snapshot.data![index])
                                    .address
                                    .toString(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No data found'),
                    );
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
