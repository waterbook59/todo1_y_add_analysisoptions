import 'package:flutter/material.dart';

import '../../../style.dart';

class EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('You don\'t have a task!!!',style: addTaskTextStyle,),
          const SizedBox(height: 16),
          Text('Complete!!!',style: taskCompleteTextStyle,),
        ],
      ),
    );
  }
}
