import 'package:moor/moor.dart';
import 'package:todo1yaddanalysisoptions/models/db/database.dart';

part 'dao.g.dart';

@UseDao(tables: [TaskRecords])
class TasksDao extends DatabaseAccessor<MyDatabase> with _$TasksDaoMixin {
  TasksDao(MyDatabase db) : super(db);

  //クエリメソッド
  //Create もし2行以上insertするときはbatchを使う
  Future<void> addTask(TaskRecord taskRecord) =>
      into(taskRecords).insert(taskRecord);

  //Read
  Future<List<TaskRecord>> get allTasks => select(taskRecords).get();

  //Update
  Future<void> updateTask(TaskRecord taskRecord) =>
      update(taskRecords).replace(taskRecord);

  //Delete
  Future<void> deleteWord(TaskRecord taskRecord) =>
      (delete(taskRecords)..where((t) => t.title.equals(taskRecord.title)))
          .go();
}
