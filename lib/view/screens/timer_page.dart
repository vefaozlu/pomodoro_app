import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/colors.dart';
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
        const Text(
          'Session Completed',
          style: TextStyle(
            color: PomodoroColors.color3,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: PomodoroColors.color2,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Give A Break',
                        style: TextStyle(
                          color: PomodoroColors.color3,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                onPressed: () =>
                    context.read<TimerBloc>().add(const StartNewSession(false)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: PomodoroColors.color2,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Study',
                        style: TextStyle(
                          color: PomodoroColors.color3,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                onPressed: () =>
                    context.read<TimerBloc>().add(const StartNewSession(true)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
