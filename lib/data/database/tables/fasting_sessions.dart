import 'package:drift/drift.dart';

class FastingSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get planType => text()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  IntColumn get targetMinutes => integer()();
  IntColumn get actualMinutes => integer().nullable()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
