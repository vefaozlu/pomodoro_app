import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/colors.dart';
import 'package:pomodoro_app/view/screens/screens.dart';
import 'package:pomodoro_app/view_model/goals_bloc/goals_bloc.dart';
import 'package:pomodoro_app/model/models/models.dart';

class A extends StatelessWidget {
  const A({Key? key, required this.goal, required this.goToInitialPage, required this.pushGoalInputPage})
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

class GoalTile extends StatefulWidget {
  const GoalTile({Key? key, required this.goal, required this.goToInitialPage})
      : super(key: key);

  final Goal goal;
  final VoidCallback goToInitialPage;

  @override
  State<GoalTile> createState() => _GoalTileState();
}

class _GoalTileState extends State<GoalTile> {
  bool isDeleted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dismissible(
        key: Key('${widget.goal.id}'),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) => context
            .read<GoalsBloc>()
            .add(DeleteGoal(goalToDelete: widget.goal)),
        child: SizedBox(
          height: 120,
          width: MediaQuery.of(context).size.width * .8,
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width * .8,
            decoration: const BoxDecoration(
              color: Colors.deepOrangeAccent,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GoalInputPage(goalToEdit: widget.goal),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.goal.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${widget.goal.pomodorosDone} of ${widget.goal.estimatedPomodoros} done',
                              style: const TextStyle(fontSize: 21),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.play_arrow_rounded,
                                size: 32,
                              ),
                              onPressed: () {
                                context.read<GoalsBloc>().add(
                                      ChangeCurrentGoal(
                                          newCurrentGoal: widget.goal),
                                    );
                                widget.goToInitialPage();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => context.read<GoalsBloc>().add(
                                    DeleteGoal(goalToDelete: widget.goal),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
