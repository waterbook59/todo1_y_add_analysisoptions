import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo1yaddanalysisoptions/data_models/task.dart';
import 'package:todo1yaddanalysisoptions/view/components/dismissible_container.dart';
import 'package:todo1yaddanalysisoptions/view/screens/add_task_screen/add_task_screen.dart';
import 'package:todo1yaddanalysisoptions/view/screens/task_screen/empty_view.dart';
import 'package:todo1yaddanalysisoptions/view/screens/task_screen/task_item.dart';
import 'package:todo1yaddanalysisoptions/view_models/task_viewmodel.dart';

class TaskListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 頭のviewModel(DB取得用)とConsumerのtaskViewModel(更新用)は違うもの
    //立ち上げと同時にConsumer１回まわる、getTaskListによりDB取得してもう１回Consumer回る、
    //そしてDBの値の数に応じてFutureBuilderで表示を変える！！！
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    Future<void>(viewModel.getTaskList);

    //アプリ立ち上げ時、awaitしても先にEmptyView();が表示されてしまう
    //「Consumer下にFutureBuilderをおいてDB結果を待ってから描画する」が正解！！！
    return Consumer<TaskViewModel>(builder: (context, taskViewModel, child) {
//      print('taskListViewのConsumer直下${taskViewModel.tasks[0].id}');

      //FutureBuilderに行かずにContainerに行ってしまう
      return FutureBuilder(
          //getListはvoidで返さずList<Task>で返ってくる形にする
          future: taskViewModel.getList(),
          builder: (context, AsyncSnapshot<List<Task>> snapshot) {
            //snapshot.hasDataはsnapshotが返ってきてるかどうか
            //snapshot.dataはsnapshotの中身のデータ(今回だとList<Task>)
            if (snapshot.hasData && snapshot.data.isEmpty) {
              print('EmptyView通った');
              return EmptyView();
            } else {
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
                        //todo Deleteするときに一瞬うつる
                        _deleteTask(context, task);
                        return;
                      }
                      if (direction == DismissDirection.startToEnd) {
                        _taskDone(context, task);
                        print('startToEnd');
                        return;
                      }
                    },
                    //Start to End(左から右)
                    background: const DismissibleContainer(isSecond: false),
                    //secondaryBackgroundはend to start
                    secondaryBackground:
                        const DismissibleContainer(isSecond: true),
                    child: TaskItem(
                      task: task,
                      // addTaskScreenへtaskを渡す
                      onTap: () => _onUpdate(context, task),
                      // TaskItemから返ってきたbool(value)をDBへ
                      taskCheck: (value) => _taskCheck(context, value, task),
                      onLongPress: () => _deleteTask(context, task),
                    ),
                  );
                },
                separatorBuilder: (context, i) => const Divider(),
              );
            }
          });
//      return Container();
    });
  }
}

//TaskItemをタップしたらtaskをAddTaskScreenへtaskを渡す
void _onUpdate(BuildContext context, Task task) {
  //ここでAddTaskScreenに渡すtaskの内容をview側からviewModelにセットするよりは
  //AddTaskScreenへtaskを渡してview側はviewModel側を読み込むだけにする
  Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
          builder: (context) => AddTaskScreen(
                editTask: task,
              )));
}

// TaskItem内のチェックボックスをタップしたらtask内のisDoneだけ更新
Future<void> _taskCheck(BuildContext context, bool value, Task task) async {
  final updateTask =
      Task(id: task.id, title: task.title, memo: task.memo, isToDo: value);
  final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
  //関数に対して名前付きパラメータで値を渡す(そのままbool値だけを渡すのはよくない)
  await taskViewModel.taskCheck(updateTask: updateTask, isDone: value);
  await taskViewModel.getTaskList();
}

Future<void> _deleteTask(BuildContext context, Task task) async {
  final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
  await taskViewModel.taskDelete(task);
  // Fluttertoast
  await Fluttertoast.showToast(
      msg: '「${task.title}」削除しました',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.purpleAccent,
      textColor: Colors.white,
      fontSize: 16);
  //消した後、taskとるの必須！！！
  await taskViewModel.getTaskList();
}

Future<void> _taskDone(BuildContext context, Task task) async {
  final doneTask =
      Task(id: task.id, title: task.title, memo: task.memo, isToDo: true);
  final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
  await taskViewModel.taskDone(updateTask: doneTask);
  await taskViewModel.getTaskList();
}
