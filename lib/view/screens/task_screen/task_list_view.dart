import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      print('taskListViewのConsumer直下${taskViewModel.tasks.length}');
//      if (taskViewModel.tasks.isEmpty) {
//        return  EmptyView();
//      }
      //ListView.separatedでListTileごとにラインがいれるためDivider使う
      return ListView.separated(
        itemCount: taskViewModel.tasks.length,
        itemBuilder: (BuildContext context, int index) {
          //CheckboxListTileを使うとonTap属性がない
          //CheckboxとonTapありのWidgetをGestureDetector使って自作
          final task = taskViewModel.tasks[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                //再表示されるが読み込むと消える
                _deleteTask(context, task);
                return;
              }
              if (direction == DismissDirection.startToEnd) {
                print('startToEnd');
                return;
              }
            },
            //Start to End(左から右)
            background: Container(color: Colors.lightGreenAccent),
            //secondaryBackgroundはend to start
            secondaryBackground:
                Container(child: const Text('何もしない'), color: Colors.purple),
            child: TaskItem(
              task: task,
              // addTaskScreenへtaskを渡す
              onTap: () => _onUpdate(context, task),
              //todo TaskItemから返ってきたbool(value)をDBへ
              taskDone: (value) => _taskDone(context, value, task),
              onLongPress: () => _deleteTask(context, task),
            ),
          );
        },
        separatorBuilder: (context, i) => const Divider(),
      );
    });
  }

//  Future<void> _clickCheckButton(bool value, BuildContext context) async {
//    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
//    taskViewModel.clickCheckButton(value);
//  }

  //todo TaskItemをタップしたらtaskをAddTaskScreenへtaskを渡す
  void _onUpdate(BuildContext context, Task task) {
//    final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    //ここでAddTaskScreenに渡すtaskの内容をview側からviewModelにセットするしかない?
    //AddTaskScreenのはじめに

    Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
            builder: (context) => AddTaskScreen(
                  editTask: task,
                )));

//    Navigator.push(context,
//        MaterialPageRoute<void>(
//            builder: (context) => AddTaskScreen(editTask: task,)));
  }

  //todo TaskItem内のチェックボックスをタップしたらtask内のisDoneだけ更新
  Future<void> _taskDone(BuildContext context, bool value, Task task) async {
    final updateTask =
        Task(id: task.id, title: task.title, memo: task.memo, isToDo: value);
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    //関数に対して名前付きパラメータで値を渡す(そのままbool値だけを渡すのはよくない)
    await taskViewModel.taskDone(updateTask: updateTask, isDone: value);
    await taskViewModel.getTaskList();
  }

  Future<void> _deleteTask(BuildContext context, Task task) async {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    await taskViewModel.taskDelete(task);
    //todo Fluttertoast
    //消した後、taskとるの必須！！！
    await taskViewModel.getTaskList();
  }
}
