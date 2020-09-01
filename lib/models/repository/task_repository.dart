

import 'package:todo1yaddanalysisoptions/models/db/dao.dart';

class TaskRepository{
  TaskRepository({TasksDao dao}):_dao = dao;
  //DI
  final TasksDao _dao;

}