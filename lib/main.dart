import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo1yaddanalysisoptions/style.dart';
import 'package:todo1yaddanalysisoptions/view/screens/task_screen/task_list_screen.dart';

import 'di/providers.dart';

void main() {
  runApp(MultiProvider(
    providers: globalProviders,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todo_1st',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness:Brightness.light,
        primaryColor: Colors.purpleAccent,
        fontFamily: regularFont,
        //AppbarとかbottomNavbarとかのアイコンのデフォルト色
        primaryIconTheme: IconThemeData(
          color: Colors.black87,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        buttonColor: Colors.white30,
        primaryIconTheme: IconThemeData(
          color: Colors.white,//AppbarとかbottomNavbarとかのデフォルト色
        ),
        iconTheme: IconThemeData(
          color: Colors.white,//bodyで使うCardとかのボタンのデフォルト色
        ),
        fontFamily: regularFont,
      ),
      home: TaskListScreen(),
    );
  }
}
