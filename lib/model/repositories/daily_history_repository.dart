import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomodoro_app/model/models/models.dart';

class DailyHistoryRepository {
  DailyHistoryRepository({required this.box});

  final Box<DailyHistory> box;

  Future<void> initialize() async {
    final int weekday = DateTime.now().weekday;

    if (box.isNotEmpty && box.values.toList()[0].weekday != weekday) {
      await box.clear();
    }
  }

  Future<void> clear() async {
    await box.clear();
  }

  List<DailyHistory> fetcItems() {
    return box.values.toList();
  }

  Future<void> changeItem({required String oldName, String? newName}) async {
    final DailyHistory? item = box.get(oldName.toLowerCase());

    if (item != null) {
      item.goalName = newName ?? oldName;
      await item.save();
    }
  }

  Future<void> incrementPomodorosDone(String name) async {
    final DailyHistory item;
    final exist = box.values.where((x) => x.goalName == name);
    if (exist.length == 1) {
      item = box.values.firstWhere((x) => x.goalName == name);
      item.pomodorosDone++;
      await item.save();
    } else {
      await box.put(
        name.toLowerCase(),
        DailyHistory(
            goalName: name, pomodorosDone: 1, weekday: DateTime.now().weekday),
      );
    }
  }

    DailyHistory? fetchLeastStudied() {
    final List<DailyHistory> items;

    if(box.isEmpty) {
      return null;
    }

    items = box.values.toList();

    int least = items[0].pomodorosDone;
    DailyHistory item = items[0];

    for(int i=0; i<items.length; i++) {
      if(items[i].pomodorosDone < least) {
        least = items[i].pomodorosDone;
        item = items[i];
      }
    }

    return item;
  }

  DailyHistory? fetchMostStudied() {
    final List<DailyHistory> items;

  if(box.isEmpty) {
    return null;
  }

    items = box.values.toList();

    int most = items[0].pomodorosDone;
    DailyHistory item = items[0];

    for(int i=0; i<items.length; i++) {
      if(items[i].pomodorosDone > most) {
        most = items[i].pomodorosDone;
        item = items[i];
      }
    }

    return item;
  }
}
