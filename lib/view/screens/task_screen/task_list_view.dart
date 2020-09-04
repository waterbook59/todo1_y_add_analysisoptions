import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo1yaddanalysisoptions/data_models/task.dart';
import 'package:todo1yaddanalysisoptions/view/screens/add_task_screen/add_task_screen.dart';
import 'package:todo1yaddanalysisoptions/view/screens/task_screen/empty_view.dart';
import 'package:todo1yaddanalysisoptions/view/screens/task_screen/task_item.dart';
import 'package:todo1yaddanalysisoptions/view_models/task_viewmodel.dart';

class TaskListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(builder: (context, taskViewModel, child) {
      print(taskViewModel.tasks);
      if (taskViewModel.tasks.isEmpty) {
        return EmptyView();
      }
      //ListView.separatedでListTileごとにラインがいれるためDivider使う
      return ListView.separated(
        itemCount: taskViewModel.tasks.length,
        itemBuilder: (BuildContext context, int index) {
          //CheckboxListTileを使うとonTap属性がない
          //CheckboxとonTapありのWidgetをGestureDetector使って自作
          final task = taskViewModel.tasks[index];
          return TaskItem(
            task: task,
            // addTaskScreenへtaskを渡す
            onTap: () => _onUpdate(context, task),
          );
        },
        separatorBuilder: (context, i) => const Divider(),
      );
    });
  }

  //todo タップしたらisTodo状態をDBへ更新
  Future<void> _clickCheckButton(bool value, BuildContext context) async {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    taskViewModel.clickCheckButton(value);
  }

  void _onUpdate(BuildContext context, Task task) {
    Navigator.push(context,
        MaterialPageRoute<void>(
            builder: (context) => AddTaskScreen(editTask: task,)));
  }
}
