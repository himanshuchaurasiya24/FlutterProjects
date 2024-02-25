import 'package:objectbox/objectbox.dart';
import 'package:todo_objectbox_windows/objectbox.g.dart';

class ObjectBox {
  late final Store store;
  ObjectBox._create(this.store) {}
  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }
}
