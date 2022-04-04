import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomodoro_app/app.dart';

import 'package:pomodoro_app/model/models/models.dart';
import 'package:pomodoro_app/model/repositories/repositories.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter<Goal>(GoalAdapter());
  Hive.registerAdapter<Settings>(SettingsAdapter());
  Hive.registerAdapter<DailyHistory>(DailyHistoryAdapter());
  Hive.registerAdapter<WeeklyHistory>(WeeklyHistoryAdapter());

  final goalsBox = await Hive.openBox<Goal>('goalsBox');
  final currentIdBox = await Hive.openBox<int>('currentIdBox');
  final settingsBox = await Hive.openBox<Settings>('settingsBox');
  final dailyHistoryBox = await Hive.openBox<DailyHistory>('dailyHistoryBox');
  final weeklyHistoryBox =
      await Hive.openBox<WeeklyHistory>('weeklyHistoryBox');

  final _goalsRepository =
      GoalsRepository(box: goalsBox, currentIdBox: currentIdBox);
  final _settingsRepository = SettingsRepository(box: settingsBox);
  final _dailyHistoryRepository = DailyHistoryRepository(box: dailyHistoryBox);
  final _weeklyHistoryRepository =
      WeeklyHistoryRepository(box: weeklyHistoryBox);

  runApp(App(
    goalsRepository: _goalsRepository,
    settingsRepository: _settingsRepository,
    dailyHistoryRepository: _dailyHistoryRepository,
    weeklyHistoryRepository: _weeklyHistoryRepository,
  ));
}
