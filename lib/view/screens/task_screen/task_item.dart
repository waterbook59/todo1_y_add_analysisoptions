import 'package:flutter/material.dart';
import 'package:todo1yaddanalysisoptions/data_models/task.dart';
import 'package:todo1yaddanalysisoptions/style.dart';

class TaskItem extends StatelessWidget {

  const TaskItem(
      {Key key,
        this.onLongPress,@required this.onTap, @required this.task, @required this.taskDone})
      : super(key: key);
  final Task task;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  //参考：https://qiita.com/welchi/items/85a2c6b13902461bb4bb
  //呼び出し元のメソッド(今回は_taskDone)に合わせて戻り値と引数の型(今回はbool)を設定
  final void Function(bool) taskDone;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //inkwell的な挙動？
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.all(8).copyWith(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(task.title,style: taskNameStyle,),
                  (task.memo.isEmpty) ? const Text('') : Text(task.memo)
                ],
              ),
            ),
            Checkbox(
              value: task.isToDo,
  //todo checkの変化をDBへ反映させる taskDone(value(task.isTodo))を呼び出し元へコンストラクタ経由で返す
              onChanged:taskDone,
            )
          ],
        ),
      ),
    );
  }
}
