import 'package:flutter/material.dart';
import 'package:todo1yaddanalysisoptions/style.dart';
import 'package:todo1yaddanalysisoptions/util/constants.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({this.editType});
  final EditType editType;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task',style: appBarTextStyle),
      ),
      body: const Text('AddTask'),
    );
  }
}
