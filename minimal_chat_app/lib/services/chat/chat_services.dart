import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return firestore.collection('Users').snapshots().map((event) {
      return event.docs.map((e) {
        final user = e.data();
        return user;
      }).toList();
    });
  }
}
