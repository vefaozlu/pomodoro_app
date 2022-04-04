import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomodoro_app/model/models/models.dart';

class SettingsRepository {
  SettingsRepository({required this.box});

  final Box<Settings> box;

  Future<void> initialize() async {
    if (box.isEmpty) await box.put('settings', Settings());
  }

  Settings fetchItems() {
    return box.get('settings')!;
  }

  Future<void> changeSettings({int? studyDuration, int? breakDuration}) async {
    final Settings item = box.get('settings')!;
    item.studyDuration = studyDuration ?? item.studyDuration;
    item.breakDuration = breakDuration ?? item.breakDuration;
    await item.save();
  }
}
