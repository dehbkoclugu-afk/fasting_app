// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FastingSessionsTable extends FastingSessions
    with TableInfo<$FastingSessionsTable, FastingSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FastingSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _planTypeMeta = const VerificationMeta(
    'planType',
  );
  @override
  late final GeneratedColumn<String> planType = GeneratedColumn<String>(
    'plan_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetMinutesMeta = const VerificationMeta(
    'targetMinutes',
  );
  @override
  late final GeneratedColumn<int> targetMinutes = GeneratedColumn<int>(
    'target_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualMinutesMeta = const VerificationMeta(
    'actualMinutes',
  );
  @override
  late final GeneratedColumn<int> actualMinutes = GeneratedColumn<int>(
    'actual_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    planType,
    startTime,
    endTime,
    targetMinutes,
    actualMinutes,
    completed,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fasting_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<FastingSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plan_type')) {
      context.handle(
        _planTypeMeta,
        planType.isAcceptableOrUnknown(data['plan_type']!, _planTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_planTypeMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('target_minutes')) {
      context.handle(
        _targetMinutesMeta,
        targetMinutes.isAcceptableOrUnknown(
          data['target_minutes']!,
          _targetMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetMinutesMeta);
    }
    if (data.containsKey('actual_minutes')) {
      context.handle(
        _actualMinutesMeta,
        actualMinutes.isAcceptableOrUnknown(
          data['actual_minutes']!,
          _actualMinutesMeta,
        ),
      );
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FastingSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FastingSession(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      planType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}plan_type'],
          )!,
      startTime:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}start_time'],
          )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      targetMinutes:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}target_minutes'],
          )!,
      actualMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_minutes'],
      ),
      completed:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}completed'],
          )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $FastingSessionsTable createAlias(String alias) {
    return $FastingSessionsTable(attachedDatabase, alias);
  }
}

class FastingSession extends DataClass implements Insertable<FastingSession> {
  final int id;
  final String planType;
  final DateTime startTime;
  final DateTime? endTime;
  final int targetMinutes;
  final int? actualMinutes;
  final bool completed;
  final String? notes;
  final DateTime createdAt;
  const FastingSession({
    required this.id,
    required this.planType,
    required this.startTime,
    this.endTime,
    required this.targetMinutes,
    this.actualMinutes,
    required this.completed,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plan_type'] = Variable<String>(planType);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    map['target_minutes'] = Variable<int>(targetMinutes);
    if (!nullToAbsent || actualMinutes != null) {
      map['actual_minutes'] = Variable<int>(actualMinutes);
    }
    map['completed'] = Variable<bool>(completed);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FastingSessionsCompanion toCompanion(bool nullToAbsent) {
    return FastingSessionsCompanion(
      id: Value(id),
      planType: Value(planType),
      startTime: Value(startTime),
      endTime:
          endTime == null && nullToAbsent
              ? const Value.absent()
              : Value(endTime),
      targetMinutes: Value(targetMinutes),
      actualMinutes:
          actualMinutes == null && nullToAbsent
              ? const Value.absent()
              : Value(actualMinutes),
      completed: Value(completed),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory FastingSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FastingSession(
      id: serializer.fromJson<int>(json['id']),
      planType: serializer.fromJson<String>(json['planType']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      targetMinutes: serializer.fromJson<int>(json['targetMinutes']),
      actualMinutes: serializer.fromJson<int?>(json['actualMinutes']),
      completed: serializer.fromJson<bool>(json['completed']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'planType': serializer.toJson<String>(planType),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'targetMinutes': serializer.toJson<int>(targetMinutes),
      'actualMinutes': serializer.toJson<int?>(actualMinutes),
      'completed': serializer.toJson<bool>(completed),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FastingSession copyWith({
    int? id,
    String? planType,
    DateTime? startTime,
    Value<DateTime?> endTime = const Value.absent(),
    int? targetMinutes,
    Value<int?> actualMinutes = const Value.absent(),
    bool? completed,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => FastingSession(
    id: id ?? this.id,
    planType: planType ?? this.planType,
    startTime: startTime ?? this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    targetMinutes: targetMinutes ?? this.targetMinutes,
    actualMinutes:
        actualMinutes.present ? actualMinutes.value : this.actualMinutes,
    completed: completed ?? this.completed,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  FastingSession copyWithCompanion(FastingSessionsCompanion data) {
    return FastingSession(
      id: data.id.present ? data.id.value : this.id,
      planType: data.planType.present ? data.planType.value : this.planType,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      targetMinutes:
          data.targetMinutes.present
              ? data.targetMinutes.value
              : this.targetMinutes,
      actualMinutes:
          data.actualMinutes.present
              ? data.actualMinutes.value
              : this.actualMinutes,
      completed: data.completed.present ? data.completed.value : this.completed,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FastingSession(')
          ..write('id: $id, ')
          ..write('planType: $planType, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('targetMinutes: $targetMinutes, ')
          ..write('actualMinutes: $actualMinutes, ')
          ..write('completed: $completed, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    planType,
    startTime,
    endTime,
    targetMinutes,
    actualMinutes,
    completed,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FastingSession &&
          other.id == this.id &&
          other.planType == this.planType &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.targetMinutes == this.targetMinutes &&
          other.actualMinutes == this.actualMinutes &&
          other.completed == this.completed &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class FastingSessionsCompanion extends UpdateCompanion<FastingSession> {
  final Value<int> id;
  final Value<String> planType;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<int> targetMinutes;
  final Value<int?> actualMinutes;
  final Value<bool> completed;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const FastingSessionsCompanion({
    this.id = const Value.absent(),
    this.planType = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.targetMinutes = const Value.absent(),
    this.actualMinutes = const Value.absent(),
    this.completed = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FastingSessionsCompanion.insert({
    this.id = const Value.absent(),
    required String planType,
    required DateTime startTime,
    this.endTime = const Value.absent(),
    required int targetMinutes,
    this.actualMinutes = const Value.absent(),
    this.completed = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : planType = Value(planType),
       startTime = Value(startTime),
       targetMinutes = Value(targetMinutes);
  static Insertable<FastingSession> custom({
    Expression<int>? id,
    Expression<String>? planType,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? targetMinutes,
    Expression<int>? actualMinutes,
    Expression<bool>? completed,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planType != null) 'plan_type': planType,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (targetMinutes != null) 'target_minutes': targetMinutes,
      if (actualMinutes != null) 'actual_minutes': actualMinutes,
      if (completed != null) 'completed': completed,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FastingSessionsCompanion copyWith({
    Value<int>? id,
    Value<String>? planType,
    Value<DateTime>? startTime,
    Value<DateTime?>? endTime,
    Value<int>? targetMinutes,
    Value<int?>? actualMinutes,
    Value<bool>? completed,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return FastingSessionsCompanion(
      id: id ?? this.id,
      planType: planType ?? this.planType,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      targetMinutes: targetMinutes ?? this.targetMinutes,
      actualMinutes: actualMinutes ?? this.actualMinutes,
      completed: completed ?? this.completed,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (planType.present) {
      map['plan_type'] = Variable<String>(planType.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (targetMinutes.present) {
      map['target_minutes'] = Variable<int>(targetMinutes.value);
    }
    if (actualMinutes.present) {
      map['actual_minutes'] = Variable<int>(actualMinutes.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FastingSessionsCompanion(')
          ..write('id: $id, ')
          ..write('planType: $planType, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('targetMinutes: $targetMinutes, ')
          ..write('actualMinutes: $actualMinutes, ')
          ..write('completed: $completed, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BodyMetricsTable extends BodyMetrics
    with TableInfo<$BodyMetricsTable, BodyMetric> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BodyMetricsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bmiMeta = const VerificationMeta('bmi');
  @override
  late final GeneratedColumn<double> bmi = GeneratedColumn<double>(
    'bmi',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    weight,
    height,
    bmi,
    date,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'body_metrics';
  @override
  VerificationContext validateIntegrity(
    Insertable<BodyMetric> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('bmi')) {
      context.handle(
        _bmiMeta,
        bmi.isAcceptableOrUnknown(data['bmi']!, _bmiMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BodyMetric map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BodyMetric(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      ),
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height'],
      ),
      bmi: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bmi'],
      ),
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}date'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $BodyMetricsTable createAlias(String alias) {
    return $BodyMetricsTable(attachedDatabase, alias);
  }
}

class BodyMetric extends DataClass implements Insertable<BodyMetric> {
  final int id;
  final double? weight;
  final double? height;
  final double? bmi;
  final DateTime date;
  final DateTime createdAt;
  const BodyMetric({
    required this.id,
    this.weight,
    this.height,
    this.bmi,
    required this.date,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<double>(height);
    }
    if (!nullToAbsent || bmi != null) {
      map['bmi'] = Variable<double>(bmi);
    }
    map['date'] = Variable<DateTime>(date);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BodyMetricsCompanion toCompanion(bool nullToAbsent) {
    return BodyMetricsCompanion(
      id: Value(id),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      height:
          height == null && nullToAbsent ? const Value.absent() : Value(height),
      bmi: bmi == null && nullToAbsent ? const Value.absent() : Value(bmi),
      date: Value(date),
      createdAt: Value(createdAt),
    );
  }

  factory BodyMetric.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BodyMetric(
      id: serializer.fromJson<int>(json['id']),
      weight: serializer.fromJson<double?>(json['weight']),
      height: serializer.fromJson<double?>(json['height']),
      bmi: serializer.fromJson<double?>(json['bmi']),
      date: serializer.fromJson<DateTime>(json['date']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'weight': serializer.toJson<double?>(weight),
      'height': serializer.toJson<double?>(height),
      'bmi': serializer.toJson<double?>(bmi),
      'date': serializer.toJson<DateTime>(date),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BodyMetric copyWith({
    int? id,
    Value<double?> weight = const Value.absent(),
    Value<double?> height = const Value.absent(),
    Value<double?> bmi = const Value.absent(),
    DateTime? date,
    DateTime? createdAt,
  }) => BodyMetric(
    id: id ?? this.id,
    weight: weight.present ? weight.value : this.weight,
    height: height.present ? height.value : this.height,
    bmi: bmi.present ? bmi.value : this.bmi,
    date: date ?? this.date,
    createdAt: createdAt ?? this.createdAt,
  );
  BodyMetric copyWithCompanion(BodyMetricsCompanion data) {
    return BodyMetric(
      id: data.id.present ? data.id.value : this.id,
      weight: data.weight.present ? data.weight.value : this.weight,
      height: data.height.present ? data.height.value : this.height,
      bmi: data.bmi.present ? data.bmi.value : this.bmi,
      date: data.date.present ? data.date.value : this.date,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BodyMetric(')
          ..write('id: $id, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('bmi: $bmi, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, weight, height, bmi, date, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BodyMetric &&
          other.id == this.id &&
          other.weight == this.weight &&
          other.height == this.height &&
          other.bmi == this.bmi &&
          other.date == this.date &&
          other.createdAt == this.createdAt);
}

class BodyMetricsCompanion extends UpdateCompanion<BodyMetric> {
  final Value<int> id;
  final Value<double?> weight;
  final Value<double?> height;
  final Value<double?> bmi;
  final Value<DateTime> date;
  final Value<DateTime> createdAt;
  const BodyMetricsCompanion({
    this.id = const Value.absent(),
    this.weight = const Value.absent(),
    this.height = const Value.absent(),
    this.bmi = const Value.absent(),
    this.date = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BodyMetricsCompanion.insert({
    this.id = const Value.absent(),
    this.weight = const Value.absent(),
    this.height = const Value.absent(),
    this.bmi = const Value.absent(),
    required DateTime date,
    this.createdAt = const Value.absent(),
  }) : date = Value(date);
  static Insertable<BodyMetric> custom({
    Expression<int>? id,
    Expression<double>? weight,
    Expression<double>? height,
    Expression<double>? bmi,
    Expression<DateTime>? date,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (weight != null) 'weight': weight,
      if (height != null) 'height': height,
      if (bmi != null) 'bmi': bmi,
      if (date != null) 'date': date,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BodyMetricsCompanion copyWith({
    Value<int>? id,
    Value<double?>? weight,
    Value<double?>? height,
    Value<double?>? bmi,
    Value<DateTime>? date,
    Value<DateTime>? createdAt,
  }) {
    return BodyMetricsCompanion(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      bmi: bmi ?? this.bmi,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (bmi.present) {
      map['bmi'] = Variable<double>(bmi.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BodyMetricsCompanion(')
          ..write('id: $id, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('bmi: $bmi, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MealsTable extends Meals with TableInfo<$MealsTable, Meal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriesMeta = const VerificationMeta(
    'calories',
  );
  @override
  late final GeneratedColumn<int> calories = GeneratedColumn<int>(
    'calories',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinMeta = const VerificationMeta(
    'protein',
  );
  @override
  late final GeneratedColumn<double> protein = GeneratedColumn<double>(
    'protein',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsMeta = const VerificationMeta('carbs');
  @override
  late final GeneratedColumn<double> carbs = GeneratedColumn<double>(
    'carbs',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatMeta = const VerificationMeta('fat');
  @override
  late final GeneratedColumn<double> fat = GeneratedColumn<double>(
    'fat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealTypeMeta = const VerificationMeta(
    'mealType',
  );
  @override
  late final GeneratedColumn<String> mealType = GeneratedColumn<String>(
    'meal_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateTime_Meta = const VerificationMeta(
    'dateTime_',
  );
  @override
  late final GeneratedColumn<DateTime> dateTime_ = GeneratedColumn<DateTime>(
    'date_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    calories,
    protein,
    carbs,
    fat,
    mealType,
    dateTime_,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Meal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(
        _caloriesMeta,
        calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta),
      );
    } else if (isInserting) {
      context.missing(_caloriesMeta);
    }
    if (data.containsKey('protein')) {
      context.handle(
        _proteinMeta,
        protein.isAcceptableOrUnknown(data['protein']!, _proteinMeta),
      );
    } else if (isInserting) {
      context.missing(_proteinMeta);
    }
    if (data.containsKey('carbs')) {
      context.handle(
        _carbsMeta,
        carbs.isAcceptableOrUnknown(data['carbs']!, _carbsMeta),
      );
    } else if (isInserting) {
      context.missing(_carbsMeta);
    }
    if (data.containsKey('fat')) {
      context.handle(
        _fatMeta,
        fat.isAcceptableOrUnknown(data['fat']!, _fatMeta),
      );
    } else if (isInserting) {
      context.missing(_fatMeta);
    }
    if (data.containsKey('meal_type')) {
      context.handle(
        _mealTypeMeta,
        mealType.isAcceptableOrUnknown(data['meal_type']!, _mealTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mealTypeMeta);
    }
    if (data.containsKey('date_time')) {
      context.handle(
        _dateTime_Meta,
        dateTime_.isAcceptableOrUnknown(data['date_time']!, _dateTime_Meta),
      );
    } else if (isInserting) {
      context.missing(_dateTime_Meta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Meal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Meal(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      calories:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}calories'],
          )!,
      protein:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}protein'],
          )!,
      carbs:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}carbs'],
          )!,
      fat:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}fat'],
          )!,
      mealType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}meal_type'],
          )!,
      dateTime_:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}date_time'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $MealsTable createAlias(String alias) {
    return $MealsTable(attachedDatabase, alias);
  }
}

class Meal extends DataClass implements Insertable<Meal> {
  final int id;
  final String name;
  final int calories;
  final double protein;
  final double carbs;
  final double fat;
  final String mealType;
  final DateTime dateTime_;
  final DateTime createdAt;
  const Meal({
    required this.id,
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.mealType,
    required this.dateTime_,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['calories'] = Variable<int>(calories);
    map['protein'] = Variable<double>(protein);
    map['carbs'] = Variable<double>(carbs);
    map['fat'] = Variable<double>(fat);
    map['meal_type'] = Variable<String>(mealType);
    map['date_time'] = Variable<DateTime>(dateTime_);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MealsCompanion toCompanion(bool nullToAbsent) {
    return MealsCompanion(
      id: Value(id),
      name: Value(name),
      calories: Value(calories),
      protein: Value(protein),
      carbs: Value(carbs),
      fat: Value(fat),
      mealType: Value(mealType),
      dateTime_: Value(dateTime_),
      createdAt: Value(createdAt),
    );
  }

  factory Meal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Meal(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      calories: serializer.fromJson<int>(json['calories']),
      protein: serializer.fromJson<double>(json['protein']),
      carbs: serializer.fromJson<double>(json['carbs']),
      fat: serializer.fromJson<double>(json['fat']),
      mealType: serializer.fromJson<String>(json['mealType']),
      dateTime_: serializer.fromJson<DateTime>(json['dateTime_']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'calories': serializer.toJson<int>(calories),
      'protein': serializer.toJson<double>(protein),
      'carbs': serializer.toJson<double>(carbs),
      'fat': serializer.toJson<double>(fat),
      'mealType': serializer.toJson<String>(mealType),
      'dateTime_': serializer.toJson<DateTime>(dateTime_),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Meal copyWith({
    int? id,
    String? name,
    int? calories,
    double? protein,
    double? carbs,
    double? fat,
    String? mealType,
    DateTime? dateTime_,
    DateTime? createdAt,
  }) => Meal(
    id: id ?? this.id,
    name: name ?? this.name,
    calories: calories ?? this.calories,
    protein: protein ?? this.protein,
    carbs: carbs ?? this.carbs,
    fat: fat ?? this.fat,
    mealType: mealType ?? this.mealType,
    dateTime_: dateTime_ ?? this.dateTime_,
    createdAt: createdAt ?? this.createdAt,
  );
  Meal copyWithCompanion(MealsCompanion data) {
    return Meal(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      calories: data.calories.present ? data.calories.value : this.calories,
      protein: data.protein.present ? data.protein.value : this.protein,
      carbs: data.carbs.present ? data.carbs.value : this.carbs,
      fat: data.fat.present ? data.fat.value : this.fat,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      dateTime_: data.dateTime_.present ? data.dateTime_.value : this.dateTime_,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Meal(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('calories: $calories, ')
          ..write('protein: $protein, ')
          ..write('carbs: $carbs, ')
          ..write('fat: $fat, ')
          ..write('mealType: $mealType, ')
          ..write('dateTime_: $dateTime_, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    calories,
    protein,
    carbs,
    fat,
    mealType,
    dateTime_,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Meal &&
          other.id == this.id &&
          other.name == this.name &&
          other.calories == this.calories &&
          other.protein == this.protein &&
          other.carbs == this.carbs &&
          other.fat == this.fat &&
          other.mealType == this.mealType &&
          other.dateTime_ == this.dateTime_ &&
          other.createdAt == this.createdAt);
}

class MealsCompanion extends UpdateCompanion<Meal> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> calories;
  final Value<double> protein;
  final Value<double> carbs;
  final Value<double> fat;
  final Value<String> mealType;
  final Value<DateTime> dateTime_;
  final Value<DateTime> createdAt;
  const MealsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.calories = const Value.absent(),
    this.protein = const Value.absent(),
    this.carbs = const Value.absent(),
    this.fat = const Value.absent(),
    this.mealType = const Value.absent(),
    this.dateTime_ = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MealsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int calories,
    required double protein,
    required double carbs,
    required double fat,
    required String mealType,
    required DateTime dateTime_,
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       calories = Value(calories),
       protein = Value(protein),
       carbs = Value(carbs),
       fat = Value(fat),
       mealType = Value(mealType),
       dateTime_ = Value(dateTime_);
  static Insertable<Meal> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? calories,
    Expression<double>? protein,
    Expression<double>? carbs,
    Expression<double>? fat,
    Expression<String>? mealType,
    Expression<DateTime>? dateTime_,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (calories != null) 'calories': calories,
      if (protein != null) 'protein': protein,
      if (carbs != null) 'carbs': carbs,
      if (fat != null) 'fat': fat,
      if (mealType != null) 'meal_type': mealType,
      if (dateTime_ != null) 'date_time': dateTime_,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MealsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? calories,
    Value<double>? protein,
    Value<double>? carbs,
    Value<double>? fat,
    Value<String>? mealType,
    Value<DateTime>? dateTime_,
    Value<DateTime>? createdAt,
  }) {
    return MealsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      mealType: mealType ?? this.mealType,
      dateTime_: dateTime_ ?? this.dateTime_,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (calories.present) {
      map['calories'] = Variable<int>(calories.value);
    }
    if (protein.present) {
      map['protein'] = Variable<double>(protein.value);
    }
    if (carbs.present) {
      map['carbs'] = Variable<double>(carbs.value);
    }
    if (fat.present) {
      map['fat'] = Variable<double>(fat.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<String>(mealType.value);
    }
    if (dateTime_.present) {
      map['date_time'] = Variable<DateTime>(dateTime_.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('calories: $calories, ')
          ..write('protein: $protein, ')
          ..write('carbs: $carbs, ')
          ..write('fat: $fat, ')
          ..write('mealType: $mealType, ')
          ..write('dateTime_: $dateTime_, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WaterIntakeTable extends WaterIntake
    with TableInfo<$WaterIntakeTable, WaterIntakeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WaterIntakeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _amountMlMeta = const VerificationMeta(
    'amountMl',
  );
  @override
  late final GeneratedColumn<int> amountMl = GeneratedColumn<int>(
    'amount_ml',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, amountMl, date, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'water_intake';
  @override
  VerificationContext validateIntegrity(
    Insertable<WaterIntakeData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount_ml')) {
      context.handle(
        _amountMlMeta,
        amountMl.isAcceptableOrUnknown(data['amount_ml']!, _amountMlMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMlMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WaterIntakeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WaterIntakeData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      amountMl:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}amount_ml'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}date'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $WaterIntakeTable createAlias(String alias) {
    return $WaterIntakeTable(attachedDatabase, alias);
  }
}

class WaterIntakeData extends DataClass implements Insertable<WaterIntakeData> {
  final int id;
  final int amountMl;
  final DateTime date;
  final DateTime createdAt;
  const WaterIntakeData({
    required this.id,
    required this.amountMl,
    required this.date,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount_ml'] = Variable<int>(amountMl);
    map['date'] = Variable<DateTime>(date);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WaterIntakeCompanion toCompanion(bool nullToAbsent) {
    return WaterIntakeCompanion(
      id: Value(id),
      amountMl: Value(amountMl),
      date: Value(date),
      createdAt: Value(createdAt),
    );
  }

  factory WaterIntakeData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WaterIntakeData(
      id: serializer.fromJson<int>(json['id']),
      amountMl: serializer.fromJson<int>(json['amountMl']),
      date: serializer.fromJson<DateTime>(json['date']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amountMl': serializer.toJson<int>(amountMl),
      'date': serializer.toJson<DateTime>(date),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WaterIntakeData copyWith({
    int? id,
    int? amountMl,
    DateTime? date,
    DateTime? createdAt,
  }) => WaterIntakeData(
    id: id ?? this.id,
    amountMl: amountMl ?? this.amountMl,
    date: date ?? this.date,
    createdAt: createdAt ?? this.createdAt,
  );
  WaterIntakeData copyWithCompanion(WaterIntakeCompanion data) {
    return WaterIntakeData(
      id: data.id.present ? data.id.value : this.id,
      amountMl: data.amountMl.present ? data.amountMl.value : this.amountMl,
      date: data.date.present ? data.date.value : this.date,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WaterIntakeData(')
          ..write('id: $id, ')
          ..write('amountMl: $amountMl, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, amountMl, date, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WaterIntakeData &&
          other.id == this.id &&
          other.amountMl == this.amountMl &&
          other.date == this.date &&
          other.createdAt == this.createdAt);
}

class WaterIntakeCompanion extends UpdateCompanion<WaterIntakeData> {
  final Value<int> id;
  final Value<int> amountMl;
  final Value<DateTime> date;
  final Value<DateTime> createdAt;
  const WaterIntakeCompanion({
    this.id = const Value.absent(),
    this.amountMl = const Value.absent(),
    this.date = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  WaterIntakeCompanion.insert({
    this.id = const Value.absent(),
    required int amountMl,
    required DateTime date,
    this.createdAt = const Value.absent(),
  }) : amountMl = Value(amountMl),
       date = Value(date);
  static Insertable<WaterIntakeData> custom({
    Expression<int>? id,
    Expression<int>? amountMl,
    Expression<DateTime>? date,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amountMl != null) 'amount_ml': amountMl,
      if (date != null) 'date': date,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  WaterIntakeCompanion copyWith({
    Value<int>? id,
    Value<int>? amountMl,
    Value<DateTime>? date,
    Value<DateTime>? createdAt,
  }) {
    return WaterIntakeCompanion(
      id: id ?? this.id,
      amountMl: amountMl ?? this.amountMl,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amountMl.present) {
      map['amount_ml'] = Variable<int>(amountMl.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WaterIntakeCompanion(')
          ..write('id: $id, ')
          ..write('amountMl: $amountMl, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      key:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}key'],
          )!,
      value:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}value'],
          )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final String key;
  final String value;
  const Setting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(key: Value(key), value: Value(value));
  }

  factory Setting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  Setting copyWith({String? key, String? value}) =>
      Setting(key: key ?? this.key, value: value ?? this.value);
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting && other.key == this.key && other.value == this.value);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<Setting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FastingSessionsTable fastingSessions = $FastingSessionsTable(
    this,
  );
  late final $BodyMetricsTable bodyMetrics = $BodyMetricsTable(this);
  late final $MealsTable meals = $MealsTable(this);
  late final $WaterIntakeTable waterIntake = $WaterIntakeTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    fastingSessions,
    bodyMetrics,
    meals,
    waterIntake,
    settings,
  ];
}

typedef $$FastingSessionsTableCreateCompanionBuilder =
    FastingSessionsCompanion Function({
      Value<int> id,
      required String planType,
      required DateTime startTime,
      Value<DateTime?> endTime,
      required int targetMinutes,
      Value<int?> actualMinutes,
      Value<bool> completed,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });
typedef $$FastingSessionsTableUpdateCompanionBuilder =
    FastingSessionsCompanion Function({
      Value<int> id,
      Value<String> planType,
      Value<DateTime> startTime,
      Value<DateTime?> endTime,
      Value<int> targetMinutes,
      Value<int?> actualMinutes,
      Value<bool> completed,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

class $$FastingSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $FastingSessionsTable> {
  $$FastingSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planType => $composableBuilder(
    column: $table.planType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetMinutes => $composableBuilder(
    column: $table.targetMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualMinutes => $composableBuilder(
    column: $table.actualMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FastingSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $FastingSessionsTable> {
  $$FastingSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planType => $composableBuilder(
    column: $table.planType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetMinutes => $composableBuilder(
    column: $table.targetMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualMinutes => $composableBuilder(
    column: $table.actualMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FastingSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FastingSessionsTable> {
  $$FastingSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get planType =>
      $composableBuilder(column: $table.planType, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get targetMinutes => $composableBuilder(
    column: $table.targetMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get actualMinutes => $composableBuilder(
    column: $table.actualMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FastingSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FastingSessionsTable,
          FastingSession,
          $$FastingSessionsTableFilterComposer,
          $$FastingSessionsTableOrderingComposer,
          $$FastingSessionsTableAnnotationComposer,
          $$FastingSessionsTableCreateCompanionBuilder,
          $$FastingSessionsTableUpdateCompanionBuilder,
          (
            FastingSession,
            BaseReferences<
              _$AppDatabase,
              $FastingSessionsTable,
              FastingSession
            >,
          ),
          FastingSession,
          PrefetchHooks Function()
        > {
  $$FastingSessionsTableTableManager(
    _$AppDatabase db,
    $FastingSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$FastingSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$FastingSessionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$FastingSessionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> planType = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<int> targetMinutes = const Value.absent(),
                Value<int?> actualMinutes = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FastingSessionsCompanion(
                id: id,
                planType: planType,
                startTime: startTime,
                endTime: endTime,
                targetMinutes: targetMinutes,
                actualMinutes: actualMinutes,
                completed: completed,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String planType,
                required DateTime startTime,
                Value<DateTime?> endTime = const Value.absent(),
                required int targetMinutes,
                Value<int?> actualMinutes = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FastingSessionsCompanion.insert(
                id: id,
                planType: planType,
                startTime: startTime,
                endTime: endTime,
                targetMinutes: targetMinutes,
                actualMinutes: actualMinutes,
                completed: completed,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FastingSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FastingSessionsTable,
      FastingSession,
      $$FastingSessionsTableFilterComposer,
      $$FastingSessionsTableOrderingComposer,
      $$FastingSessionsTableAnnotationComposer,
      $$FastingSessionsTableCreateCompanionBuilder,
      $$FastingSessionsTableUpdateCompanionBuilder,
      (
        FastingSession,
        BaseReferences<_$AppDatabase, $FastingSessionsTable, FastingSession>,
      ),
      FastingSession,
      PrefetchHooks Function()
    >;
typedef $$BodyMetricsTableCreateCompanionBuilder =
    BodyMetricsCompanion Function({
      Value<int> id,
      Value<double?> weight,
      Value<double?> height,
      Value<double?> bmi,
      required DateTime date,
      Value<DateTime> createdAt,
    });
typedef $$BodyMetricsTableUpdateCompanionBuilder =
    BodyMetricsCompanion Function({
      Value<int> id,
      Value<double?> weight,
      Value<double?> height,
      Value<double?> bmi,
      Value<DateTime> date,
      Value<DateTime> createdAt,
    });

class $$BodyMetricsTableFilterComposer
    extends Composer<_$AppDatabase, $BodyMetricsTable> {
  $$BodyMetricsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bmi => $composableBuilder(
    column: $table.bmi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BodyMetricsTableOrderingComposer
    extends Composer<_$AppDatabase, $BodyMetricsTable> {
  $$BodyMetricsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bmi => $composableBuilder(
    column: $table.bmi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BodyMetricsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BodyMetricsTable> {
  $$BodyMetricsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<double> get bmi =>
      $composableBuilder(column: $table.bmi, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BodyMetricsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BodyMetricsTable,
          BodyMetric,
          $$BodyMetricsTableFilterComposer,
          $$BodyMetricsTableOrderingComposer,
          $$BodyMetricsTableAnnotationComposer,
          $$BodyMetricsTableCreateCompanionBuilder,
          $$BodyMetricsTableUpdateCompanionBuilder,
          (
            BodyMetric,
            BaseReferences<_$AppDatabase, $BodyMetricsTable, BodyMetric>,
          ),
          BodyMetric,
          PrefetchHooks Function()
        > {
  $$BodyMetricsTableTableManager(_$AppDatabase db, $BodyMetricsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BodyMetricsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$BodyMetricsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$BodyMetricsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<double?> height = const Value.absent(),
                Value<double?> bmi = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BodyMetricsCompanion(
                id: id,
                weight: weight,
                height: height,
                bmi: bmi,
                date: date,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<double?> height = const Value.absent(),
                Value<double?> bmi = const Value.absent(),
                required DateTime date,
                Value<DateTime> createdAt = const Value.absent(),
              }) => BodyMetricsCompanion.insert(
                id: id,
                weight: weight,
                height: height,
                bmi: bmi,
                date: date,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BodyMetricsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BodyMetricsTable,
      BodyMetric,
      $$BodyMetricsTableFilterComposer,
      $$BodyMetricsTableOrderingComposer,
      $$BodyMetricsTableAnnotationComposer,
      $$BodyMetricsTableCreateCompanionBuilder,
      $$BodyMetricsTableUpdateCompanionBuilder,
      (
        BodyMetric,
        BaseReferences<_$AppDatabase, $BodyMetricsTable, BodyMetric>,
      ),
      BodyMetric,
      PrefetchHooks Function()
    >;
typedef $$MealsTableCreateCompanionBuilder =
    MealsCompanion Function({
      Value<int> id,
      required String name,
      required int calories,
      required double protein,
      required double carbs,
      required double fat,
      required String mealType,
      required DateTime dateTime_,
      Value<DateTime> createdAt,
    });
typedef $$MealsTableUpdateCompanionBuilder =
    MealsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> calories,
      Value<double> protein,
      Value<double> carbs,
      Value<double> fat,
      Value<String> mealType,
      Value<DateTime> dateTime_,
      Value<DateTime> createdAt,
    });

class $$MealsTableFilterComposer extends Composer<_$AppDatabase, $MealsTable> {
  $$MealsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbs => $composableBuilder(
    column: $table.carbs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateTime_ => $composableBuilder(
    column: $table.dateTime_,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MealsTableOrderingComposer
    extends Composer<_$AppDatabase, $MealsTable> {
  $$MealsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbs => $composableBuilder(
    column: $table.carbs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateTime_ => $composableBuilder(
    column: $table.dateTime_,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MealsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealsTable> {
  $$MealsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<double> get protein =>
      $composableBuilder(column: $table.protein, builder: (column) => column);

  GeneratedColumn<double> get carbs =>
      $composableBuilder(column: $table.carbs, builder: (column) => column);

  GeneratedColumn<double> get fat =>
      $composableBuilder(column: $table.fat, builder: (column) => column);

  GeneratedColumn<String> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumn<DateTime> get dateTime_ =>
      $composableBuilder(column: $table.dateTime_, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MealsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealsTable,
          Meal,
          $$MealsTableFilterComposer,
          $$MealsTableOrderingComposer,
          $$MealsTableAnnotationComposer,
          $$MealsTableCreateCompanionBuilder,
          $$MealsTableUpdateCompanionBuilder,
          (Meal, BaseReferences<_$AppDatabase, $MealsTable, Meal>),
          Meal,
          PrefetchHooks Function()
        > {
  $$MealsTableTableManager(_$AppDatabase db, $MealsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$MealsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$MealsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$MealsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> calories = const Value.absent(),
                Value<double> protein = const Value.absent(),
                Value<double> carbs = const Value.absent(),
                Value<double> fat = const Value.absent(),
                Value<String> mealType = const Value.absent(),
                Value<DateTime> dateTime_ = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MealsCompanion(
                id: id,
                name: name,
                calories: calories,
                protein: protein,
                carbs: carbs,
                fat: fat,
                mealType: mealType,
                dateTime_: dateTime_,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int calories,
                required double protein,
                required double carbs,
                required double fat,
                required String mealType,
                required DateTime dateTime_,
                Value<DateTime> createdAt = const Value.absent(),
              }) => MealsCompanion.insert(
                id: id,
                name: name,
                calories: calories,
                protein: protein,
                carbs: carbs,
                fat: fat,
                mealType: mealType,
                dateTime_: dateTime_,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MealsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealsTable,
      Meal,
      $$MealsTableFilterComposer,
      $$MealsTableOrderingComposer,
      $$MealsTableAnnotationComposer,
      $$MealsTableCreateCompanionBuilder,
      $$MealsTableUpdateCompanionBuilder,
      (Meal, BaseReferences<_$AppDatabase, $MealsTable, Meal>),
      Meal,
      PrefetchHooks Function()
    >;
typedef $$WaterIntakeTableCreateCompanionBuilder =
    WaterIntakeCompanion Function({
      Value<int> id,
      required int amountMl,
      required DateTime date,
      Value<DateTime> createdAt,
    });
typedef $$WaterIntakeTableUpdateCompanionBuilder =
    WaterIntakeCompanion Function({
      Value<int> id,
      Value<int> amountMl,
      Value<DateTime> date,
      Value<DateTime> createdAt,
    });

class $$WaterIntakeTableFilterComposer
    extends Composer<_$AppDatabase, $WaterIntakeTable> {
  $$WaterIntakeTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMl => $composableBuilder(
    column: $table.amountMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WaterIntakeTableOrderingComposer
    extends Composer<_$AppDatabase, $WaterIntakeTable> {
  $$WaterIntakeTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMl => $composableBuilder(
    column: $table.amountMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WaterIntakeTableAnnotationComposer
    extends Composer<_$AppDatabase, $WaterIntakeTable> {
  $$WaterIntakeTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amountMl =>
      $composableBuilder(column: $table.amountMl, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$WaterIntakeTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WaterIntakeTable,
          WaterIntakeData,
          $$WaterIntakeTableFilterComposer,
          $$WaterIntakeTableOrderingComposer,
          $$WaterIntakeTableAnnotationComposer,
          $$WaterIntakeTableCreateCompanionBuilder,
          $$WaterIntakeTableUpdateCompanionBuilder,
          (
            WaterIntakeData,
            BaseReferences<_$AppDatabase, $WaterIntakeTable, WaterIntakeData>,
          ),
          WaterIntakeData,
          PrefetchHooks Function()
        > {
  $$WaterIntakeTableTableManager(_$AppDatabase db, $WaterIntakeTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WaterIntakeTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$WaterIntakeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$WaterIntakeTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> amountMl = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => WaterIntakeCompanion(
                id: id,
                amountMl: amountMl,
                date: date,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int amountMl,
                required DateTime date,
                Value<DateTime> createdAt = const Value.absent(),
              }) => WaterIntakeCompanion.insert(
                id: id,
                amountMl: amountMl,
                date: date,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WaterIntakeTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WaterIntakeTable,
      WaterIntakeData,
      $$WaterIntakeTableFilterComposer,
      $$WaterIntakeTableOrderingComposer,
      $$WaterIntakeTableAnnotationComposer,
      $$WaterIntakeTableCreateCompanionBuilder,
      $$WaterIntakeTableUpdateCompanionBuilder,
      (
        WaterIntakeData,
        BaseReferences<_$AppDatabase, $WaterIntakeTable, WaterIntakeData>,
      ),
      WaterIntakeData,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          Setting,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
          Setting,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      Setting,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
      Setting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FastingSessionsTableTableManager get fastingSessions =>
      $$FastingSessionsTableTableManager(_db, _db.fastingSessions);
  $$BodyMetricsTableTableManager get bodyMetrics =>
      $$BodyMetricsTableTableManager(_db, _db.bodyMetrics);
  $$MealsTableTableManager get meals =>
      $$MealsTableTableManager(_db, _db.meals);
  $$WaterIntakeTableTableManager get waterIntake =>
      $$WaterIntakeTableTableManager(_db, _db.waterIntake);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}
