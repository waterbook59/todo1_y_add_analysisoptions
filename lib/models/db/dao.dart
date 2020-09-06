import 'package:moor/moor.dart';
import 'package:todo1yaddanalysisoptions/models/db/database.dart';

part 'dao.g.dart';

@UseDao(tables: [TaskRecords])
class TasksDao extends DatabaseAccessor<MyDatabase> with _$TasksDaoMixin {
  TasksDao(MyDatabase db) : super(db);

  //クエリメソッド
  //todo TaskRecordではなく、 TaskRecordsCompanionを使ってtitle,memo,isToDo(できるか不明)のみ登録
  //Create
  // 自動採番してinsert,クエリ2行以上はbatch使う
  Future<void> addTask(TaskRecord taskRecord) =>
      into(taskRecords).insert(taskRecord);

  //Read
  Future<List<TaskRecord>> get allTasks => select(taskRecords).get();

  //Update
  Future<void> updateTask(TaskRecord taskRecord) =>
      update(taskRecords).replace(taskRecord);

  //Delete
  Future<void> deleteWord(TaskRecord taskRecord) =>
      (delete(taskRecords)..where((t) => t.id.equals(taskRecord.id)))
          .go();
}
