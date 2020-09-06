import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo1yaddanalysisoptions/data_models/task.dart';
import 'package:todo1yaddanalysisoptions/style.dart';
import 'package:todo1yaddanalysisoptions/util/constants.dart';
import 'package:todo1yaddanalysisoptions/view/components/input_part.dart';
import 'package:todo1yaddanalysisoptions/view/screens/task_screen/task_list_screen.dart';
import 'package:todo1yaddanalysisoptions/view_models/task_viewmodel.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({this.editType, this.editTask});

  final Task editTask;
  final EditType editType;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    Future<void>(() async {
      _isEdit()
          ? await viewModel.getUpdateTask(editTask)
          //なんかいいのがないから空Container
          : Container();
    });

    //今回wiipopscopeいらん
    return WillPopScope(
      //Navigator.popは有効にしながら戻る時にtextControllerクリアにする
      onWillPop: () async {
        viewModel.textClear();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                viewModel.textClear();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => TaskListScreen()));},
            ),
            //ここはConsumerにせずにeditTask有無によって条件分岐すれば良いのでは？
            //isEdit()?Text():Text()ではなく、Text(isEdit()?---:xxx)の方がシンプル
            title: Text(_isEdit() ? 'Save Task' : 'Add Task',
                style: appBarTextStyle)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: <Widget>[
              const SizedBox(height: 20),
              //viewModel内のTextEditingControllerを取ってきて分割先のInputPartへ投げるイメージ
              Consumer<TaskViewModel>(builder: (context, model, child) {
                return InputPart(
                  label: 'Name',
                  //todo 更新の場合の条件追加isEdit()?textEditingController:editTask.title
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
              //ボタンを横幅いっぱいに伸ばしたい
              // 方法1.SizedBox(width:double.infinity,height:,child:ボタン)
              // 方法2.ButtonTheme(minWidth:,height:,child:ボタン)指定
              SizedBox(
                  width: double.infinity,
                  height: 75,
                  child: RaisedButton(
                    //todo ボタン押したらDBへ追加・更新 Fluttertoast表記
                    onPressed: () => _onTaskRegistered(context, editType),
                    color: Colors.purpleAccent,
                    //ここの表記もConsumerじゃなくてisEdit()でText表記変える？
                    child: Text(_isEdit() ? 'Update' : 'Add',
                        style: buttonTextStyle),
                  )),

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
            ]),
          ),
        ),
      ),
    );
    //const Center(child: Text('AddTask')),
  }

  //todo ボタン押したらDBへ追加・更新 Fluttertoast表記
  //viewからviewModelへメソッドを投げる時に条件分岐がある場合のやり方
  //１.view側で条件分岐しておいてviewModelは別々にシンプルにメソッドを作る
  //２.とりあえずviewModelのメソッドを呼び出してviewModelの中で条件分岐を行う
  Future<void> _onTaskRegistered(
      BuildContext context, EditType editType) async {
    print('押したら登録してTaskListへ戻る');
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    //todo validateNameした後
    _isEdit()
        ? await viewModel.onUpdateTaskRegistered(editTask)
        : await viewModel.onAddTaskRegistered();
    //todo Fluttertoast表記 isEdit()?更新しました:登録しました
//    _isEdit()
//        ?Fluttertoast

    viewModel.textClear();
    //更新して戻るにはpushReplacement必要
    await Navigator.pushReplacement(context,
        MaterialPageRoute<void>(builder: (context) => TaskListScreen()));
  }

  //nullじゃない場合true、nullだったらfalse返す
  bool _isEdit() {
    return editTask != null;
  }

//ここでappBarのデフォルトのNavigator.popを使えなくする
//  Future<bool> _backToListScreen(BuildContext context) {
//    Navigator.pushReplacement(context,
//        MaterialPageRoute<void>(builder: (context) => TaskListScreen()));
//    return Future.value(false);
//  }

}

//２画面でpushReplacementしてしまうとappBarの戻る使えない？手動でleading設置してみる
//_backToTaskList() {
//
//}
