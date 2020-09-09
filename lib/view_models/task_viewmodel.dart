import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:todo1yaddanalysisoptions/data_models/task.dart';
import 'package:todo1yaddanalysisoptions/models/repository/task_repository.dart';
import 'package:todo1yaddanalysisoptions/util/constants.dart';

class TaskViewModel extends ChangeNotifier{


  TaskViewModel({TaskRepository repository}):_taskRepository=repository;
  final TaskRepository _taskRepository;

  List<Task> _tasks = <Task>[];
  //taskのリストをview層からとるとUnmodifiableListViewで返す
  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }
  //いらんかも
  bool _isDone =false;
  bool get isDone => _isDone;

  TextEditingController get taskNameController => _taskNameController;
  TextEditingController get taskMemoController => _taskMemoController;
  //the getter 'text' was called on null flutterエラーがでたら
  // It looks like you have not initialized your TextEditingController.
  TextEditingController _taskNameController= TextEditingController();
  TextEditingController _taskMemoController = TextEditingController();
  //いらんかも
  String _titleText;
  String get titleText => _titleText;




  Future<void> getTaskList() async{
    _tasks = await _taskRepository.getTaskList();

    if(_tasks.isEmpty){
      print('リストが空です');
      notifyListeners();
    }else{
      print('DB=>レポジトリ=>vieModelで取得したデータの１番目：${_tasks[0].id}');
      notifyListeners();
    }
  }

  Future<List<Task>> getList() async{
    _tasks = await _taskRepository.getList();
    //ここでnotifyListeners();するとConsumer回り続ける
//    notifyListeners();
    return _tasks;
  }


  //今回viewModel側で条件分岐は行わずview側で行うのでeditTypeで場合わけなし

  Future<void>onAddTaskRegistered() async{
    print('onAddTask:viewModel層: ${_taskNameController.text}');
    final  task = Task(
      //idはautoIncrementするので、初期登録は何も入れなくて良い！！！
      title: _taskNameController.text,
      memo: _taskMemoController.text,
      isToDo: false,
    );
    await _taskRepository.onAddTaskRegistered(task);
    notifyListeners();
  }

  Future<void>onUpdateTaskRegistered(Task editTask) async{
//結局controllerの値更新しないと・・・
  final updateTask = Task(
    id: editTask.id,
    title:_taskNameController.text,
    memo: _taskMemoController.text,
  );
    await _taskRepository.onUpdateTaskRegistered(updateTask);
    notifyListeners();
  }

  void getUpdateTask(Task editTask) {
    _taskNameController.text = editTask.title;
    _taskMemoController.text = editTask.memo;
    notifyListeners();
  }

  void textClear() {
    _taskNameController.clear();
    _taskMemoController.clear();
  }

  Future<void> taskDelete(Task task) async{
   await _taskRepository.taskDelete(task);
   notifyListeners();
  }

  //TaskItem内のチェックボックスをチェックしたらtask内のisDoneだけ更新
  //関数に対して名前付きパラメータで値を受け取る！！！
  //関数名({引数の型 引数名(これが名前になる)})
  Future<void> taskCheck({Task updateTask,bool isDone}) async{
    await _taskRepository.onUpdateTaskRegistered(updateTask);
    notifyListeners();
  }


  Future<void> taskDone({Task updateTask}) async{
    await _taskRepository.onUpdateTaskRegistered(updateTask);
    notifyListeners();
  }

}