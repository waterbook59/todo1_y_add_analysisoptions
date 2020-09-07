
import 'package:todo1yaddanalysisoptions/data_models/task.dart';
import 'package:todo1yaddanalysisoptions/models/db/database.dart';



//リスト形式ではなくて１行単位
//Dartのモデルクラス(Task)=>DBのテーブルクラス(TaskRecord)へ変換

extension ConvertToTaskRecord on Task{

  TaskRecord toTaskRecord(Task task){
    // var wordRecord = WordRecord();のインスタンスは作らず直接代入
    //varではなくfinalでも良い
    final  taskRecord = TaskRecord(
      id:task.id,
      title:task.title ?? '',
      memo:task.memo ?? '',
      isToDo: task.isToDo ?? false,
    );
    return taskRecord;
  }
}


//DBのテーブルクラス(WordRecord)=> Dartのモデルクラス(task)へ変換
extension ConvertToTasks on List<TaskRecord>{

  List<Task> toTasks(List<TaskRecord> taskRecords){
    // varではなくfinalでも良い
    final tasks = <Task>[];
    //todo forEach書き方変える
    taskRecords.forEach((taskRecord){
      tasks.add(
          Task(
            id: taskRecord.id,
            title:taskRecord.title ?? '',
            memo:taskRecord.memo ?? '',
            isToDo: taskRecord.isToDo ?? false,
          )
      );
    });
    return tasks;
  }
}