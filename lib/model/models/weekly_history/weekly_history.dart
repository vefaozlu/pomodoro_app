import 'package:hive_flutter/adapters.dart';

part 'weekly_history.g.dart';

@HiveType(typeId: 3)
class WeeklyHistory extends HiveObject {
  @HiveField(0)
  final int weekday;

  @HiveField(1)
  int pomodorosDone;

  WeeklyHistory({required this.weekday, this.pomodorosDone = 0});
}
