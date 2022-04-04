import 'package:hive_flutter/adapters.dart';

part 'goal.g.dart';

@HiveType(typeId: 0)
class Goal extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String? note;

  @HiveField(2)
  int estimatedPomodoros;

  @HiveField(3)
  int pomodorosDone;

  @HiveField(5)
  final int id;

  Goal({
    required this.name,
    this.note,
    required this.estimatedPomodoros,
    this.pomodorosDone = 0,
    required this.id,
  });

  Goal copyWith({
    String? name,
    String? note,
    int? estimatedPomodoros,
    int? pomodorosDone,
  }) {
    return Goal(
      name: name ?? this.name,
      note: note ?? this.note,
      estimatedPomodoros: estimatedPomodoros ?? this.estimatedPomodoros,
      pomodorosDone: pomodorosDone ?? this.pomodorosDone,
      id: id,
    );
  }
}
