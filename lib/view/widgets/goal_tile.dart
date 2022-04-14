import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/colors.dart';
import 'package:pomodoro_app/view_model/goals_bloc/goals_bloc.dart';
import 'package:pomodoro_app/model/models/models.dart';

class GoalTile extends StatelessWidget {
  const GoalTile({Key? key, required this.goal, required this.goToInitialPage, required this.pushGoalInputPage})
      : super(key: key);

  final Goal goal;
  final VoidCallback goToInitialPage;
  final Function pushGoalInputPage;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('${goal.id}'),
      onDismissed: (direction) => context.read<GoalsBloc>().add(DeleteGoal(goalToDelete: goal)),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(goal.name,
                        style: const TextStyle(
                            color: PomodoroColors.color3,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    Text(
                        '${goal.pomodorosDone} of ${goal.estimatedPomodoros} done',
                        style: const TextStyle(
                            color: PomodoroColors.color3, fontSize: 18)),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: PomodoroColors.color3),
                    onPressed: () => pushGoalInputPage(goal),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: PomodoroColors.color3),
                    onPressed: () => context.read<GoalsBloc>().add(
                          DeleteGoal(goalToDelete: goal),
                        ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.play_arrow_rounded,
                        size: 32, color: PomodoroColors.color3),
                    onPressed: () {
                      context
                          .read<GoalsBloc>()
                          .add(ChangeCurrentGoal(newCurrentGoal: goal));
                      goToInitialPage();
                    },
                  ),
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(color: PomodoroColors.color3),
          ),
        ],
      ),
    );
  }
}


