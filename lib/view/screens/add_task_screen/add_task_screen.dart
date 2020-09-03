import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo1yaddanalysisoptions/style.dart';
import 'package:todo1yaddanalysisoptions/util/constants.dart';
import 'package:todo1yaddanalysisoptions/view/components/input_part.dart';
import 'package:todo1yaddanalysisoptions/view_models/task_viewmodel.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({this.editType});

  final EditType editType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //ここはConsumerにせずにeditTypeによって条件分岐すれば良いのでは？
        title: Consumer<TaskViewModel>(builder: (context, model, child) {
          return Text(
            model.titleText,
            style: appBarTextStyle,
          );
        }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              //viewModel内のTextEditingControllerを取ってきて分割先のInputPartへ投げるイメージ
              Consumer<TaskViewModel>(builder: (context, model, child) {
                return InputPart(
                  label: 'Name',
                  textEditingController: model.taskNameController,
                );
              }),
              const SizedBox(height: 20),
              Consumer<TaskViewModel>(builder: (context, model, child) {
                return InputPart(
                    label: 'Memo',
                    textEditingController: model.taskMemoController);
              }),
              const SizedBox(height: 30),
              //ここの表記もConsumerじゃなくてeditTypeでText表記変える？

              //ボタンを横幅いっぱいに伸ばしたい
              // 方法1.SizedBox(width:double.infinity,height:,child:ボタン)
              // 方法2.ButtonTheme(minWidth:,height:,child:ボタン)指定
              SizedBox(
                width: double.infinity,
                height: 75,
                child: RaisedButton(
                    //todo ボタン押したらDBへ追加・更新 Fluttertoast表記
                    onPressed: _onTaskRegistered,
                    color: Colors.purpleAccent,
                    child: Text(
                      'Add or Update',
                      style: buttonTextStyle,
                    )),
              ),
//              ButtonTheme(
//                minWidth: 300, height: 75, child: RaisedButton(
//                //todo ボタン押したらDBへ追加・更新 Fluttertoast表記
//                  onPressed: _onTaskRegistered,
//                  color: Colors.purpleAccent,
//                  child: Text(
//                    'ボタン',
//                    style: buttonTextStyle,
//                  )),
//              )
            ],
          ),
        ),
      ),

      //const Center(child: Text('AddTask')),
    );
  }

  Text _onTaskRegistered() {
    print('押したら登録してTaskListへ戻る');
    return const Text('');
  }
}
