import 'package:flutter/material.dart';
import 'package:todo1yaddanalysisoptions/util/constants.dart';

import '../../style.dart';
import 'add_task_screen.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task List',
          style: appBarTextStyle,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            tooltip: '新たに追加',
            onPressed: () => _addTodo(context, EditType.add),
          ),
        ],
      ),
    );
  }

  void _addTodo(BuildContext context, EditType add) {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (context) => const AddTaskScreen(
                  editType:  EditType.add,
                )));
  }
}
