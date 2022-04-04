import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/colors.dart';
import 'package:pomodoro_app/view_model/view_model.dart';

class TimerPart extends StatelessWidget {
  const TimerPart({Key? key, required this.duration}) : super(key: key);

  final int duration;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TimerState state = context.watch<TimerBloc>().state;
    double sweepAngle = state.timerForStudy
        ? duration * (360 / TimerBloc.studyDuration)
        : duration * (360 / TimerBloc.breakDuration);
    return Column(
      children: [
        Flexible(
          flex: 4,
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: CustomPaint(
              size: Size(size.width, size.height),
              child: Center(
                child: Text(
                  '${(duration / 60).floor().toString().padLeft(2, '0')} : ${(duration % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 36, color: PomodoroColors.color3),
                ),
              ),
              painter: Painter(),
              foregroundPainter: ForegroundPainter(sweepAngle: sweepAngle),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: BlocBuilder<GoalsBloc, GoalsState>(
            builder: (context, goalsState) {
              if (goalsState is GoalsSuccess &&
                  goalsState.currentGoal != null) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(child: ResetButton()),
                    Expanded(child: PlayPauseButton(state: state)),
                    Expanded(child: SkipButton(state: state)),
                  ],
                );
              }
              return const Center(
                child: Text('Please Select A Goal To Use Timer', style: TextStyle(color: PomodoroColors.color3)),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SkipButton extends StatelessWidget {
  const SkipButton({Key? key, required this.state}) : super(key: key);

  final TimerState state;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.skip_next, size: 36, color: PomodoroColors.color3),
      onPressed: () =>
          context.read<TimerBloc>().add(SkipSession(state.timerForStudy)),
    );
  }
}

class PlayPauseButton extends StatefulWidget {
  const PlayPauseButton({Key? key, required this.state}) : super(key: key);

  final TimerState state;

  @override
  State<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
          widget.state is TimerRunInProgress
              ? Icons.pause
              : Icons.play_arrow_rounded,
          size: 36,
          color: PomodoroColors.color3),
      onPressed: () => widget.state is TimerRunInProgress
          ? context.read<TimerBloc>().add(PauseTimer(widget.state.duration))
          : context.read<TimerBloc>().add(
              StartTimer(widget.state.duration, widget.state.timerForStudy)),
    );
  }
}

class ResetButton extends StatelessWidget {
  const ResetButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.restart_alt,
        size: 32,
        color: PomodoroColors.color3,
      ),
      onPressed: () => context.read<TimerBloc>().add(const ResetTimer()),
    );
  }
}

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = PomodoroColors.color2
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    double convert(int degree) => degree * (3.1415 / 180);

    final path = Path()
      ..arcTo(
          Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            height: size.height * .9,
            width: size.height * .9,
          ),
          convert(270),
          convert(360),
          false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant Painter oldDelegate) => false;
}

class ForegroundPainter extends CustomPainter {
  ForegroundPainter({required this.sweepAngle});
  final double sweepAngle;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = PomodoroColors.color3
      ..strokeWidth = 10.5
      ..style = PaintingStyle.stroke;

    double convert(double degree) => degree * (3.1415 / 180);

    final path = Path()
      ..arcTo(
          Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            height: size.height * .9,
            width: size.height * .9,
          ),
          convert(270),
          convert(sweepAngle),
          false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ForegroundPainter oldDelegate) =>
      oldDelegate.sweepAngle != sweepAngle;
}
