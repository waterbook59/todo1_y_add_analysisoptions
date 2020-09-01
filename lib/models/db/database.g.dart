// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class TaskRecord extends DataClass implements Insertable<TaskRecord> {
  final String title;
  final String memo;
  final bool isToDo;
  TaskRecord(
      {@required this.title, @required this.memo, @required this.isToDo});
  factory TaskRecord.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return TaskRecord(
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      memo: stringType.mapFromDatabaseResponse(data['${effectivePrefix}memo']),
      isToDo:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_to_do']),
    );
  }
  factory TaskRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TaskRecord(
      title: serializer.fromJson<String>(json['title']),
      memo: serializer.fromJson<String>(json['memo']),
      isToDo: serializer.fromJson<bool>(json['isToDo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'memo': serializer.toJson<String>(memo),
      'isToDo': serializer.toJson<bool>(isToDo),
    };
  }

  @override
  TaskRecordsCompanion createCompanion(bool nullToAbsent) {
    return TaskRecordsCompanion(
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
      isToDo:
          isToDo == null && nullToAbsent ? const Value.absent() : Value(isToDo),
    );
  }

  TaskRecord copyWith({String title, String memo, bool isToDo}) => TaskRecord(
        title: title ?? this.title,
        memo: memo ?? this.memo,
        isToDo: isToDo ?? this.isToDo,
      );
  @override
  String toString() {
    return (StringBuffer('TaskRecord(')
          ..write('title: $title, ')
          ..write('memo: $memo, ')
          ..write('isToDo: $isToDo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(title.hashCode, $mrjc(memo.hashCode, isToDo.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TaskRecord &&
          other.title == this.title &&
          other.memo == this.memo &&
          other.isToDo == this.isToDo);
}

class TaskRecordsCompanion extends UpdateCompanion<TaskRecord> {
  final Value<String> title;
  final Value<String> memo;
  final Value<bool> isToDo;
  const TaskRecordsCompanion({
    this.title = const Value.absent(),
    this.memo = const Value.absent(),
    this.isToDo = const Value.absent(),
  });
  TaskRecordsCompanion.insert({
    @required String title,
    @required String memo,
    this.isToDo = const Value.absent(),
  })  : title = Value(title),
        memo = Value(memo);
  TaskRecordsCompanion copyWith(
      {Value<String> title, Value<String> memo, Value<bool> isToDo}) {
    return TaskRecordsCompanion(
      title: title ?? this.title,
      memo: memo ?? this.memo,
      isToDo: isToDo ?? this.isToDo,
    );
  }
}

class $TaskRecordsTable extends TaskRecords
    with TableInfo<$TaskRecordsTable, TaskRecord> {
  final GeneratedDatabase _db;
  final String _alias;
  $TaskRecordsTable(this._db, [this._alias]);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _memoMeta = const VerificationMeta('memo');
  GeneratedTextColumn _memo;
  @override
  GeneratedTextColumn get memo => _memo ??= _constructMemo();
  GeneratedTextColumn _constructMemo() {
    return GeneratedTextColumn(
      'memo',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isToDoMeta = const VerificationMeta('isToDo');
  GeneratedBoolColumn _isToDo;
  @override
  GeneratedBoolColumn get isToDo => _isToDo ??= _constructIsToDo();
  GeneratedBoolColumn _constructIsToDo() {
    return GeneratedBoolColumn('is_to_do', $tableName, false,
        defaultValue: const Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [title, memo, isToDo];
  @override
  $TaskRecordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'task_records';
  @override
  final String actualTableName = 'task_records';
  @override
  VerificationContext validateIntegrity(TaskRecordsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (d.memo.present) {
      context.handle(
          _memoMeta, memo.isAcceptableValue(d.memo.value, _memoMeta));
    } else if (isInserting) {
      context.missing(_memoMeta);
    }
    if (d.isToDo.present) {
      context.handle(
          _isToDoMeta, isToDo.isAcceptableValue(d.isToDo.value, _isToDoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {title};
  @override
  TaskRecord map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TaskRecord.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TaskRecordsCompanion d) {
    final map = <String, Variable>{};
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.memo.present) {
      map['memo'] = Variable<String, StringType>(d.memo.value);
    }
    if (d.isToDo.present) {
      map['is_to_do'] = Variable<bool, BoolType>(d.isToDo.value);
    }
    return map;
  }

  @override
  $TaskRecordsTable createAlias(String alias) {
    return $TaskRecordsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TaskRecordsTable _taskRecords;
  $TaskRecordsTable get taskRecords => _taskRecords ??= $TaskRecordsTable(this);
  TasksDao _tasksDao;
  TasksDao get tasksDao => _tasksDao ??= TasksDao(this as MyDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [taskRecords];
}
