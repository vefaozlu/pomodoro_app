import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomodoro_app/model/models/models.dart';

class WeeklyHistoryRepository {
  WeeklyHistoryRepository({required this.box});

  final Box<WeeklyHistory> box;

  Future<void> clear() async {
    await box.clear();
  }

  Future<void> incrementPomodorosDone() async {
    if (box.isEmpty) {
      await box.put(1, WeeklyHistory(weekday: 1));
      await box.put(2, WeeklyHistory(weekday: 2));
      await box.put(3, WeeklyHistory(weekday: 3));
      await box.put(4, WeeklyHistory(weekday: 4));
      await box.put(5, WeeklyHistory(weekday: 5));
      await box.put(6, WeeklyHistory(weekday: 6));
      await box.put(7, WeeklyHistory(weekday: 7));
    }
    final int weekday = DateTime.now().weekday;
    final WeeklyHistory item = box.get(weekday)!;

    item.pomodorosDone++;
    await item.save();
  }

  String fetchLeastStudied() {
    final List<WeeklyHistory> items;
    items = box.values.toList();

    int least = items[0].pomodorosDone;
    int weekday = 1;

    for (int i = 0; i < items.length; i++) {
      print(least);
      if (items[i].pomodorosDone < least) {
        least = items[i].pomodorosDone;
        weekday = items[i].weekday;
      }
    }

    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      default:
        return 'Sunday';
    }
  }

  String fetchMostStudied() {
    final List<WeeklyHistory> items;
    items = box.values.toList();

    int most = items[0].pomodorosDone;
    int weekday = 1;

    for (int i = 0; i < items.length; i++) {
      if (items[i].pomodorosDone > most) {
        most = items[i].pomodorosDone;
        weekday = items[i].weekday;
      }
    }

    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      default:
        return 'Sunday';
    }
  }

  List<WeeklyHistory> fetchItems() {
    return box.values.toList();
  }
}
