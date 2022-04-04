import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro_app/model/models/models.dart';
import 'package:pomodoro_app/model/repositories/repositories.dart';

part 'goal_input_state.dart';

class GoalInputCubit extends Cubit<GoalInputState> {
  final GoalsRepository _repository;
  final Goal? _goalToEdit;
  GoalInputCubit({required GoalsRepository repository, Goal? goalToEdit})
      : _repository = repository,
        _goalToEdit = goalToEdit,
        super(goalToEdit == null
            ? const GoalInputState()
            : GoalInputState(
                name: goalToEdit.name,
                note: goalToEdit.note ?? '',
                estimatedPomodoros: goalToEdit.estimatedPomodoros));

  void onValueChanged({String? name, String? note, int? estimatedPomodoros}) {
    emit(GoalInputState(
        name: name ?? state.name,
        note: note ?? state.note,
        estimatedPomodoros: estimatedPomodoros ?? state.estimatedPomodoros));
  }

  void saveChanges(
      {required String name,
      required String note,
      required int estimatedPomodoros}) {
    if (_goalToEdit != null) {
      _repository.changeItem(
          name: name,
          note: note,
          estimatedPomodoros: estimatedPomodoros,
          pomodorosDone: _goalToEdit!.pomodorosDone,
          id: _goalToEdit!.id);
    } else {
      _repository.addItem(
          name: name, note: note, estimatedPomodoros: estimatedPomodoros);
    }
  }
}
