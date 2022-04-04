import 'package:hive_flutter/adapters.dart';

part 'daily_history.g.dart';

@HiveType(typeId: 2)
class DailyHistory extends HiveObject {
  @HiveField(0)
  int weekday;

  @HiveField(1)
  String goalName;

  @HiveField(2)
  int pomodorosDone;

  DailyHistory(
      {required this.weekday,
      required this.goalName,
      this.pomodorosDone = 0,});

  DailyHistory copyWith(
      {int? weekday, String? goalName, int? pomodorosDone}) {
    return DailyHistory(
      weekday: weekday ?? this.weekday,
      goalName: goalName ?? this.goalName,
      pomodorosDone: pomodorosDone ?? this.pomodorosDone,
    );
  }
}
