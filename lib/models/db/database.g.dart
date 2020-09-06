// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class TaskRecord extends DataClass implements Insertable<TaskRecord> {
  final int id;
  final String title;
  final String memo;
  final bool isToDo;
  TaskRecord(
      {@required this.id,
      @required this.title,
      @required this.memo,
      @required this.isToDo});
  factory TaskRecord.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return TaskRecord(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
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
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      memo: serializer.fromJson<String>(json['memo']),
      isToDo: serializer.fromJson<bool>(json['isToDo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'memo': serializer.toJson<String>(memo),
      'isToDo': serializer.toJson<bool>(isToDo),
    };
  }

  @override
  TaskRecordsCompanion createCompanion(bool nullToAbsent) {
    return TaskRecordsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
      isToDo:
          isToDo == null && nullToAbsent ? const Value.absent() : Value(isToDo),
    );
  }

  TaskRecord copyWith({int id, String title, String memo, bool isToDo}) =>
      TaskRecord(
        id: id ?? this.id,
        title: title ?? this.title,
        memo: memo ?? this.memo,
        isToDo: isToDo ?? this.isToDo,
      );
  @override
  String toString() {
    return (StringBuffer('TaskRecord(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('memo: $memo, ')
          ..write('isToDo: $isToDo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(title.hashCode, $mrjc(memo.hashCode, isToDo.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TaskRecord &&
          other.id == this.id &&
          other.title == this.title &&
          other.memo == this.memo &&
          other.isToDo == this.isToDo);
}

class TaskRecordsCompanion extends UpdateCompanion<TaskRecord> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> memo;
  final Value<bool> isToDo;
  const TaskRecordsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.memo = const Value.absent(),
    this.isToDo = const Value.absent(),
  });
  TaskRecordsCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    @required String memo,
    this.isToDo = const Value.absent(),
  })  : title = Value(title),
        memo = Value(memo);
  TaskRecordsCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<String> memo,
      Value<bool> isToDo}) {
    return TaskRecordsCompanion(
      id: id ?? this.id,
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
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

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
  List<GeneratedColumn> get $columns => [id, title, memo, isToDo];
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
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskRecord map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TaskRecord.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TaskRecordsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
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
