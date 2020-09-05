import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo1yaddanalysisoptions/util/constants.dart';
import 'package:todo1yaddanalysisoptions/view/screens/task_screen/task_list_view.dart';
import 'package:todo1yaddanalysisoptions/view_models/task_viewmodel.dart';

import '../../../style.dart';
import '../add_task_screen/add_task_screen.dart';

class TaskListScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    //todo アプリ立ち上げ時、awaitしても先にEmptyView();が表示されてしまう
//    Future<void>(viewModel.getTaskList);
    Future<void>(()async{
      await viewModel.getTaskList();
      //todo ここでEmptyView表示指示すべき
    });
    //中身が空の時の表記はTaskListView内で表示

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
      body: TaskListView(),
    );
  }

  void _addTodo(BuildContext context, EditType add) {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (context) =>
            const AddTaskScreen(
              editType: EditType.add,
            )));
  }
}
