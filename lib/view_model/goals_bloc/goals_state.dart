part of 'goals_bloc.dart';

abstract class GoalsState extends Equatable {
  const GoalsState();

  @override
  List<Object?> get props => [];
}

class GoalsLoading extends GoalsState {
  const GoalsLoading();
}

class GoalsSuccess extends GoalsState {
  const GoalsSuccess({required this.goals, this.currentGoal});

  final List<Goal> goals;
  final Goal? currentGoal;

@override
List<Object?> get props => [goals, currentGoal];
}
