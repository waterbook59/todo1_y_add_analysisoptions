
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
    //todo returnなしだとエラー
  return _result =resultTaskRecords.toTasks(resultTaskRecords);
  }

}