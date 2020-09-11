import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo1yaddanalysisoptions/data_models/task.dart';
import 'package:todo1yaddanalysisoptions/style.dart';
import 'package:todo1yaddanalysisoptions/util/constants.dart';
import 'package:todo1yaddanalysisoptions/view/components/input_part.dart';
import 'package:todo1yaddanalysisoptions/view/screens/task_screen/task_list_screen.dart';
import 'package:todo1yaddanalysisoptions/view_models/task_viewmodel.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({this.editTask});

  final Task editTask;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    Future<void>(() async {
      _isEdit()
          ? viewModel.getUpdateTask(editTask)
          //なんかいいのがないから空Container
          : Container();
    });

    //今回2画面のみなのでwiipopscopeいらん
    return
//      WillPopScope(
//      //Navigator.popは有効にしながら戻る時にtextControllerクリアにする
//      onWillPop: () async {
//        viewModel.textClear();
//        return false;
//      },
//      child:
        Scaffold(
      appBar: AppBar(
          //２画面でpushReplacementしてしまうとappBarの戻る使えないので手動でleading設置してみる
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              viewModel.textClear();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => TaskListScreen()));
            },
          ),
          //isEdit()?Text():Text()ではなく、Text(isEdit()?---:xxx)の方がシンプル
          title: Text(_isEdit() ? 'Save Task' : 'Add Task',
              style: appBarTextStyle)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: <Widget>[
            const SizedBox(height: 20),
            //viewModel内のTextEditingControllerを取ってきて、
            // Widget分割先のInputPartのTextFieldへ投げるイメージ
            Consumer<TaskViewModel>(builder: (context, model, child) {
              return InputPart(
                label: 'Name',
                textEditingController: model.taskNameController,
                errorText: model.validateName ? model.strValidateName : null,
                //アップデート時に書き換え始めたらエラーメッセージ消す
                //なぜupdateValidateNameした時に_validateNameがtrueになっているかというと..
                // その前にonTaskRegisteredして、trueにセットされているから
                didChanged: (value) {//valueにはString入ってInputPartから返ってくる(今回使わない)
                  print('didChanged/value:{$value}');
                  viewModel.updateValidateName();
                },
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
                  //ボタン押したらDBへ追加・更新 Fluttertoast表記
                  onPressed: () => _onTaskRegistered(context),
                  color: Colors.purpleAccent,
                  //ここの表記もConsumerじゃなくてisEdit()でText表記変える
                  child: Text(_isEdit() ? 'Update' : 'Add',
                      style: buttonTextStyle),
                )),
          ]),
        ),
      ),
    );
//    );
  }

  // ボタン押したらDBへ追加・更新 Fluttertoast表記
  //viewからviewModelへメソッドを投げる時に条件分岐がある場合のやり方
  //１.view側で条件分岐しておいてviewModelは別々にシンプルにメソッドを作る
  //２.とりあえずviewModelのメソッドを呼び出してviewModelの中で条件分岐を行う
  Future<void> _onTaskRegistered(
    BuildContext context,
  ) async {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);

    //ボタン押す時にvalidate、
    viewModel.setValidateName(value:true);
    if(viewModel.validateTaskName()) {
      _isEdit()
          ? await viewModel.onUpdateTaskRegistered(editTask)
          : await viewModel.onAddTaskRegistered();
      await Fluttertoast.showToast(
          msg: _isEdit()
              ? '「${viewModel.taskNameController.text}」更新しました'
              : '「${viewModel.taskNameController.text}」登録しました',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.purpleAccent,
          textColor: Colors.white,
          fontSize: 16);

      viewModel.textClear();
      //更新して戻るにはpushReplacement必要
      await Navigator.pushReplacement(context,
          MaterialPageRoute<void>(builder: (context) => TaskListScreen()));
    }
  }

  //nullじゃない場合true、nullだったらfalse返す
  bool _isEdit() {
    return editTask != null;
  }
}
