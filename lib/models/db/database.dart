
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
  TextColumn get title => text()();
  TextColumn get memo =>text()();
  BoolColumn get isToDo => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {title};
}

@UseMoor(tables: [TaskRecords],daos: [TasksDao])
class MyDatabase extends _$MyDatabase{
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;


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
