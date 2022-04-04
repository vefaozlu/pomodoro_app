part of 'goals_bloc.dart';

abstract class GoalsEvent extends Equatable {
  const GoalsEvent();

  @override
  List<Object> get props => [];
}

class FetchItems extends GoalsEvent {
  const FetchItems();
}

class DeleteGoal extends GoalsEvent {
  const DeleteGoal({required this.goalToDelete});

  final Goal goalToDelete;

  @override
  List<Object> get props => [goalToDelete];
}

class GoalInputStarted extends GoalsEvent {
  const GoalInputStarted({required this.goalToEdit});

  final Goal? goalToEdit;

  @override
  List<Object> get props => [goalToEdit!];
}

class ChangeCurrentGoal extends GoalsEvent {
  const ChangeCurrentGoal({required this.newCurrentGoal});

  final Goal newCurrentGoal;

  @override
  List<Object> get props => [newCurrentGoal];
}
