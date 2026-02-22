import 'package:drift/drift.dart';

class WaterIntake extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get amountMl => integer()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
