import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo1yaddanalysisoptions/data_models/task.dart';
import 'package:todo1yaddanalysisoptions/util/constants.dart';
import 'package:todo1yaddanalysisoptions/view/screens/task_screen/empty_view.dart';
import 'package:todo1yaddanalysisoptions/view/screens/task_screen/task_list_view.dart';
import 'package:todo1yaddanalysisoptions/view_models/task_viewmodel.dart';

import '../../../style.dart';
import '../add_task_screen/add_task_screen.dart';

class TaskListScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<TaskViewModel>(context, listen: false);

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
            onPressed: () => _addTodo(context),
          ),
        ],
      ),
      body: TaskListView(),
//    }
//        }
      );

//    );
  }

  void _addTodo(BuildContext context) {

    Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
            builder: (context) =>
            const AddTaskScreen(

            )));
  }
}
