import 'package:objectbox/objectbox.dart';

@Entity()
class TodoEntity {
  int id = 0;
  String? task_title;
  String? task_description;
  bool? task_done;
  DateTime? creation_date;
  TodoEntity({
    this.task_title,
    this.task_description,
    this.task_done,
    this.creation_date,
  });
}
