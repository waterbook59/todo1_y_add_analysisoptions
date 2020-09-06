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
    return
      Consumer<TaskViewModel>(builder: (context, taskViewModel, child) {
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
          return TaskItem(
            task: task,
            // addTaskScreenへtaskを渡す
            onTap: () => _onUpdate(context, task),
            //todo TaskItemから返ってきたbool(value)をDBへ
            taskDone: (value)=>_taskDone(context,value,task),
            onLongPress: ()=>_deleteTask(context,task),
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
            builder: (context) => AddTaskScreen(editTask: task,)));


//    Navigator.push(context,
//        MaterialPageRoute<void>(
//            builder: (context) => AddTaskScreen(editTask: task,)));

  }

  //todo TaskItem内のチェックボックスをタップしたらtask内のisDoneだけ更新
  Future<void>_taskDone(BuildContext context,bool value, Task task) async{
    final updateTask =Task(title: task.title,memo: task.memo,isToDo: value);
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
   await taskViewModel.taskDone(updateTask);
  }

  Future<void> _deleteTask(BuildContext context,Task task) async{
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    await taskViewModel.taskDelete(task);
    //todo Fluttertoast
    //消した後、taskとるの必須！！！
    await taskViewModel.getTaskList();
  }


}
