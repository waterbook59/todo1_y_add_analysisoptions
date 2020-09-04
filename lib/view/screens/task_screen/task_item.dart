import 'package:flutter/material.dart';
import 'package:todo1yaddanalysisoptions/data_models/task.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({Key key, @required this.onTap, @required this.task})
      : super(key: key);
  final Task task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //inkwell的な挙動？
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(task.title),
                (task.memo.isEmpty) ? const Text('') : Text(task.memo)
              ],
            ),
          ),
          Checkbox(value: task.isToDo,
              //todo checkの変化をDBへ反映させる valueChangeでtrue,falseを呼び出し元へコンストラクタ経由で返す?
              onChanged: null)
        ],
      ),
    );
  }
}
