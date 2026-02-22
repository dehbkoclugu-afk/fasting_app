import 'package:drift/drift.dart';

class Meals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get calories => integer()();
  RealColumn get protein => real()();
  RealColumn get carbs => real()();
  RealColumn get fat => real()();
  TextColumn get mealType => text()(); // breakfast, lunch, dinner, snack
  DateTimeColumn get dateTime_ => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
