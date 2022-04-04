import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/colors.dart';
import 'package:pomodoro_app/model/models/models.dart';
import 'package:pomodoro_app/view_model/view_model.dart';

class CurrentGoalCard extends StatefulWidget {
  const CurrentGoalCard({Key? key, required this.pushGoalInputPage}) : super(key: key);

  final Function pushGoalInputPage;

  @override
  State<CurrentGoalCard> createState() => _CurrentGoalCardState();
}

class _CurrentGoalCardState extends State<CurrentGoalCard> {
  bool isExpanded = false;
  final shrinkedHeight = 75.0;
  final expandMultiplier = 3.5;

  @override
  Widget build(BuildContext context) {
    final GoalsState state = context.watch<GoalsBloc>().state;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: !isExpanded ? shrinkedHeight : shrinkedHeight * expandMultiplier,
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
        color: PomodoroColors.color2,
        borderRadius: BorderRadius.circular(25),
      ),
      child: state is GoalsSuccess && state.currentGoal != null
          ? Column(
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () => setState(() => isExpanded = !isExpanded),
                  child: SizedBox(
                    height: shrinkedHeight,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CurrentGoalTile(
                            goal: state.currentGoal!,
                            shrinkedHeight: shrinkedHeight,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: AnimatedRotation(
                            duration: const Duration(milliseconds: 300),
                            turns: isExpanded ? .5 : 0,
                            child: const Icon(Icons.expand_more,
                                color: PomodoroColors.color3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                    height: isExpanded
                        ? shrinkedHeight * (expandMultiplier - 1)
                        : 0,
                    child: HideablePart(
                      isExpanded: isExpanded,
                      pushGoalInputPage: widget.pushGoalInputPage,
                      goal: state.currentGoal!,
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: Text(
                "There isn't any current goal",
                style: TextStyle(
                  fontSize: 16,
                  color: PomodoroColors.color3,
                ),
              ),
            ),
    );
  }
}

class CurrentGoalTile extends StatefulWidget {
  const CurrentGoalTile(
      {Key? key, required this.goal, required this.shrinkedHeight})
      : super(key: key);
  final Goal goal;
  final double shrinkedHeight;

  @override
  State<CurrentGoalTile> createState() => CurrentGoalTileState();
}

class CurrentGoalTileState extends State<CurrentGoalTile>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController controller;
  late double end;
  double sweepAngle = 0.0;

  @override
  void initState() {
    end = widget.goal.pomodorosDone * (360 / widget.goal.estimatedPomodoros);

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = Tween(begin: 0.0, end: end).animate(controller)
      ..addListener(
        () {
          setState(() => sweepAngle = animation.value);
        },
      );

    controller.forward();

    controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          controller.stop();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomPaint(
          painter: CurrentGoalPainter(),
          foregroundPainter:
              CurrentGoalForegroundPainter(sweepAngle: sweepAngle),
          size: Size(widget.shrinkedHeight * .95, widget.shrinkedHeight * .95),
        ),
        Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.goal.name,
                style: const TextStyle(
                  color: PomodoroColors.color3,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${widget.goal.pomodorosDone} of ${widget.goal.estimatedPomodoros} done',
                style: const TextStyle(
                  color: PomodoroColors.color3,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class HideablePart extends StatelessWidget {
  const HideablePart({Key? key, required this.isExpanded, required this.goal, required this.pushGoalInputPage})
      : super(key: key);
  final Goal goal;
  final Function pushGoalInputPage;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              width: MediaQuery.of(context).size.width * .85,
              decoration: BoxDecoration(
                color: const Color(0xFFAC4940),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Note:',
                      style: TextStyle(
                        color: PomodoroColors.color3,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      goal.note ?? ' ',
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                        color: PomodoroColors.color3,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            child: isExpanded
                ? IconButton(
                    onPressed: () => pushGoalInputPage(goal),
                    icon: const Icon(
                      Icons.edit,
                      size: 28,
                      color: PomodoroColors.color3,
                    ),
                  )
                : const SizedBox(),
          ),
        ),
      ],
    );
  }
}

class CurrentGoalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = PomodoroColors.color1
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke;

    double convert(int degree) => degree * (3.1415 / 180);

    final path = Path()
      ..arcTo(
          Rect.fromCenter(
            center: Offset(size.height / 2, size.width / 2),
            height: size.height * .8,
            width: size.width * .8,
          ),
          convert(270),
          convert(360),
          false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CurrentGoalPainter oldDelegate) => false;
}

class CurrentGoalForegroundPainter extends CustomPainter {
  CurrentGoalForegroundPainter({required this.sweepAngle});
  final double sweepAngle;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = PomodoroColors.color3
      ..strokeWidth = 7.5
      ..style = PaintingStyle.stroke;

    double convert(double degree) => degree * (3.1415 / 180);

    final path = Path()
      ..arcTo(
          Rect.fromCenter(
            center: Offset(size.height / 2, size.width / 2),
            height: size.height * .8,
            width: size.width * .8,
          ),
          convert(270),
          convert(sweepAngle),
          false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CurrentGoalForegroundPainter oldDelegate) =>
      oldDelegate.sweepAngle != sweepAngle;
}
