import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo1yaddanalysisoptions/models/db/dao.dart';
import 'package:todo1yaddanalysisoptions/models/db/database.dart';
import 'package:todo1yaddanalysisoptions/models/repository/task_repository.dart';
import 'package:todo1yaddanalysisoptions/view_models/task_viewmodel.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels =[
  Provider<MyDatabase>(
    create: (_)=>MyDatabase(),
    dispose: (_,db) =>db.close(),
  ),
];


List<SingleChildWidget> dependentModels = [
  ProxyProvider<MyDatabase,TasksDao>(
    update: (_, db, dao)=>TasksDao(db),
  ),
  ProxyProvider<TasksDao,TaskRepository>(
    update: (_, dao, repository)=>TaskRepository(dao: dao),
  ),
];

//chapter98 RepositoryにChangeNotifierProxyProvider
List<SingleChildWidget> viewModels =[
  ChangeNotifierProvider<TaskViewModel>(
    create: (context)=> TaskViewModel(
      repository:Provider.of<TaskRepository>(context, listen: false),
    ),
  ),
];