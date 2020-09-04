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
  bool _isDone =false;
  bool get isDone => _isDone;

  TextEditingController get taskNameController => _taskNameController;
  TextEditingController get taskMemoController => _taskMemoController;
  //the getter 'text' was called on null flutterエラーがでたら
  // It looks like you have not initialized your TextEditingController.
  TextEditingController _taskNameController= TextEditingController();
  TextEditingController _taskMemoController = TextEditingController();
  String _titleText='タイトル';
  String get titleText => _titleText;




  Future<void> getTaskList() async{
    _tasks = await _taskRepository.getTaskList();
    if(_tasks.isEmpty){
      print('リストが空です');
      notifyListeners();
    }else{
      print('DB=>レポジトリ=>vieModelで取得したデータの１番目：${_tasks[0].title}');
      notifyListeners();
    }
  }

  //todo タップしたらisTodo状態をDBへ更新 isTodoだけをDB上で更新
  //AVOID positional boolean parameters.
  //bool値は名前付パラメータで渡すのが原則
//  Future<void> clickCheckButton(bool value) async{
//    print('value:$value');
//    _isDone= value;
//    notifyListeners();
//  }

  //今回viewModel側で条件分岐は行わずview側で行うのでeditTypeで場合わけなし
//  Future<void> onTaskRegistered(EditType editType) async{
//    var  task = Task(
//      title: _taskNameController.text,
//      memo: _taskMemoController.text,
//      isToDo: false,
//    );
//    //editTypeで登録方法場合わけ
//    switch(editType){
//      case EditType.add:
//        _taskRepository.addTaskRegistered();
//        break;
//      case EditType.upload:
//        _taskRepository.uploadTaskRegistered();
//    }
//  }

  //todo TaskItem内のチェックボックスをチェックしたらtask内のisDoneだけ更新
  Future<void> taskDone(Task updateTask) async{
    await _taskRepository.taskDone(updateTask);
    notifyListeners();
  }

  Future<void>onAddTaskRegistered() async{
    print('onAddTask:viewModel層: ${_taskNameController.text}');
    final  task = Task(
      title: _taskNameController.text,
      memo: _taskMemoController.text,
      isToDo: false,
    );
    await _taskRepository.onAddTaskRegistered(task);
    notifyListeners();
  }

  Future<void>onUpdateTaskRegistered(Task editTask) async{
    await _taskRepository.onUpdateTaskRegistered(editTask);
    notifyListeners();
  }
}