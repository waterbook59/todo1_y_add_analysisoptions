
import 'package:moor_ffi/database.dart';
import 'package:todo1yaddanalysisoptions/util/extensions.dart';
import 'package:todo1yaddanalysisoptions/data_models/task.dart';
import 'package:todo1yaddanalysisoptions/models/db/dao.dart';

class TaskRepository{
  TaskRepository({TasksDao dao}):_dao = dao;
  //DI
  final TasksDao _dao;
  List<Task> _result = <Task>[];

  Future<List<Task>> getTaskList() async{
    final resultTaskRecords = await _dao.allTasks;
    // returnなしだとエラー
  return _result =resultTaskRecords.toTasks(resultTaskRecords);
  }

  Future<void> onAddTaskRegistered(Task task) async{
    print('onAddTask:viewModel層');
    try{
      final taskRecord =task.toTaskRecord(task);
      print('repository:登録taskRecordのid:task${taskRecord.id}');
      await _dao.addTask(taskRecord);
    }on SqliteException catch(e){
      //ここでエラーを返さずにviewとviewModelのvalidationの条件に同じタイトルを弾くようにしてみる
      print('repositoryエラー:この問題はすでに登録${e.toString()}');
    }
  }

  Future<void> onUpdateTaskRegistered(Task editTask) async{
    try{
      final taskRecord =editTask.toTaskRecord(editTask);
      await _dao.updateTask(taskRecord);
    }on SqliteException catch(error){
      print('repositoryエラー:この問題はすでに登録${error.toString()}');
  }

  }

//  Future<void> taskDone({Task updateTask,bool isDone}) {
//  print('repository/taskDone:ここでupdateTaskのidを基にisDoneの値をinsertする');
//  }

  Future<void> taskDelete(Task task) async{
    final taskRecord =task.toTaskRecord(task);
    await _dao.deleteWord(taskRecord);
  }
}