import 'package:drift/drift.dart';

class BodyMetrics extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get weight => real().nullable()();
  RealColumn get height => real().nullable()();
  RealColumn get bmi => real().nullable()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
