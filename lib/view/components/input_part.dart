import 'package:flutter/material.dart';
import 'package:todo1yaddanalysisoptions/style.dart';

class InputPart extends StatelessWidget {
  const InputPart({this.label,this.textEditingController});
  final String label;
  final TextEditingController textEditingController;
//  final bool isTextInputEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      //TextとTextField左寄せ、デフォルトは中央よせ
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label,style: addTaskTextStyle,textAlign: TextAlign.start,),
        Padding(
          padding: const EdgeInsets.only(top:15),
          child: TextField(
            controller: textEditingController,
//            enabled: isTextInputEnabled,
            style: inputTextStyle,
            keyboardType: TextInputType.text,
            //todo decoration:InputDecoration()をいれるとバリデーション後表示してくる？
//            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
