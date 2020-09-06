
import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:todo1yaddanalysisoptions/models/db/dao.dart';
//partの後ろは''必須
part 'database.g.dart';


//moor.dartのTableを引き継ぐ
class TaskRecords extends Table{
  //primaryKey用にid作成
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get memo =>text()();
  BoolColumn get isToDo => boolean().withDefault(const Constant(false))();

  //同じタイトルのtodoが入れられるようにprimaryKeyをtitleではなくidへ変更する
//  @override
//  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [TaskRecords],daos: [TasksDao])
class MyDatabase extends _$MyDatabase{
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  //統合処理
  @override
  MigrationStrategy get migration => MigrationStrategy(
      onCreate: (Migrator m) {
        return m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {
          // we added the dueDate property in the change from version 1
          await m.addColumn(taskRecords, taskRecords.id);
        }
      }
  );

}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'task.db'));
    return VmDatabase(file);
  });
}
