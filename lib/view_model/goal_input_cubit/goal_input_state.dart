part of 'goal_input_cubit.dart';

class GoalInputState extends Equatable {
  const GoalInputState(
      {this.name = '', this.note = '', this.estimatedPomodoros = 5});

  final String name;
  final String note;
  final int estimatedPomodoros;

/*   GoalInputState copyWith({String? name, String? note, int? estimatedPomodoros}) {
    return GoalInputState(
        name: name ?? this.name,
        note: note ?? this.note,
        estimatedPomodoros: estimatedPomodoros ?? this.estimatedPomodoros);
  } */

  @override
  List<Object> get props => [name, note, estimatedPomodoros];
}
