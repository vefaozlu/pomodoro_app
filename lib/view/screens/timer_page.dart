import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/view/widgets/widgets.dart';
import 'package:pomodoro_app/view_model/view_model.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key, required this.pushGoalInputPage})
      : super(key: key);

  final Function pushGoalInputPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 55,
            child: BlocBuilder<TimerBloc, TimerState>(
              builder: (context, state) {
                if (state is TimerLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is TimerRunCompleted) {
                  return const TimerCompleted();
                }
                return TimerPart(duration: state.duration);
              },
            ),
          ),
          // TODO Rewrite This Widget.
          Flexible(
            fit: FlexFit.loose,
            flex: 45,
            child: CurrentGoalCard(pushGoalInputPage: pushGoalInputPage),
          ),
        ],
      ),
    );
  }
}

class TimerCompleted extends StatelessWidget {
  const TimerCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Session Completed'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text('Give A Break'),
              onPressed: () =>
                  context.read<TimerBloc>().add(const StartNewSession(false)),
            ),
            TextButton(
              child: const Text('Study'),
              onPressed: () =>
                  context.read<TimerBloc>().add(const StartNewSession(true)),
            ),
          ],
        ),
      ],
    );
  }
}
