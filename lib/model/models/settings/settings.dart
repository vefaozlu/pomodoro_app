import 'package:hive_flutter/adapters.dart';

part 'settings.g.dart';

@HiveType(typeId: 1)
class Settings extends HiveObject {
  @HiveField(0)
  int studyDuration;

  @HiveField(1)
  int breakDuration;

  Settings({this.studyDuration = 1500, this.breakDuration = 300});

  Settings copyWith({int? studyDuration, int? breakDuration}) {
    return Settings(
        studyDuration: studyDuration ?? this.studyDuration,
        breakDuration: breakDuration ?? this.breakDuration);
  }
}
