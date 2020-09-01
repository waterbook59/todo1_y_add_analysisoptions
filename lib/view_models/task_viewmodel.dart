import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo1yaddanalysisoptions/data_models/task.dart';
import 'package:todo1yaddanalysisoptions/models/repository/task_repository.dart';

class TaskViewModel extends ChangeNotifier{
  TaskViewModel({TaskRepository repository}):_taskRepository=repository;
  final TaskRepository _taskRepository;
  List<Task> _tasks = <Task>[];




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
}