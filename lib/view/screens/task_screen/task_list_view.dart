import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo1yaddanalysisoptions/view/screens/task_screen/empty_view.dart';
import 'package:todo1yaddanalysisoptions/view_models/task_viewmodel.dart';

class TaskListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(builder: (context, taskViewModel, child) {
      print(taskViewModel.tasks);
      if (taskViewModel.tasks.isEmpty) {
        return EmptyView();
      }
      //ListView.separatedでDivider使わなくてもListTileごとにラインが入るのでは？？？
      return ListView.builder(
          itemCount: taskViewModel.tasks.length * 2,
          itemBuilder: (BuildContext context, int index) {
            if (index.isOdd) return const Divider();
            final i = index ~/ 2;
            return CheckboxListTile(
              title: Text(taskViewModel.tasks[i].title),
              subtitle: Text(taskViewModel.tasks[i].memo),
              value: taskViewModel.tasks[i].isToDo,
               //todo タップしたらisTodo状態をDBへ更新
              onChanged: (value) => _clickCheckButton(value, context),
            );
          });
    });
  }

  //todo タップしたらisTodo状態をDBへ更新
  Future<void> _clickCheckButton(bool value, BuildContext context) async {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    taskViewModel.clickCheckButton(value);
  }
}
