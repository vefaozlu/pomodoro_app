import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomodoro_app/model/models/models.dart';

class GoalsRepository {
  GoalsRepository({required this.box, required this.currentIdBox});

  final Box<Goal> box;
  final Box<int> currentIdBox;

  Future<void> initialize() async {
    if (currentIdBox.isEmpty) {
      await currentIdBox.put('currentItemId', -1);
    }
  }

  Future<void> close() async {
    await box.close();
  }

  Future<void> clear() async {
    await box.clear();
    await currentIdBox.put('currentItemId', -1);
  }

  Future<void> addItem(
      {required String name, String? note, required estimatedPomodoros}) async {
    int id = box.isEmpty ? -1 : box.values.toList()[box.values.length - 1].id;

    await box.put(
      ++id,
      Goal(
        name: name,
        note: note,
        estimatedPomodoros: estimatedPomodoros,
        id: id,
      ),
    );
  }

  List<Goal> fetchItems() {
    return box.values.toList();
  }

  Future<void> changeItem(
      {String? name,
      String? note,
      int? estimatedPomodoros,
      required int pomodorosDone,
      required int id}) async {
    final Goal itemToChange = box.get(id)!;
    await box.put(
        id,
        Goal(
          name: name ?? itemToChange.name,
          note: note ?? itemToChange.note,
          estimatedPomodoros:
              estimatedPomodoros ?? itemToChange.estimatedPomodoros,
          pomodorosDone: pomodorosDone,
          id: itemToChange.id,
        ));
  }

  Future<void> deleteItem({required int id}) async {
    await box.delete(id);
    if (box.isEmpty || id == currentIdBox.get('currentItemId')) {
      await currentIdBox.put('currentItemId', -1);
    }
  }

  Goal? fetchCurrentItem() {
    final int currentId = currentIdBox.get('currentItemId')!;
    if (currentId != -1) {
      return box.get(currentId);
    }
    return null;
  }

  Future<Goal> changeCurrentItem({required int id}) async {
    await currentIdBox.put('currentItemId', id);
    return box.get(id)!;
  }

  Future<void> incrementPomodorosDone() async {
    final int currentId = currentIdBox.get('currentItemId')!;
    final Goal currentGoal = box.get(currentId)!;

    currentGoal.pomodorosDone++;
    await currentGoal.save();

    if (currentGoal.estimatedPomodoros == currentGoal.pomodorosDone) {
      deleteItem(id: currentId);
    }
  }
}
