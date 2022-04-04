import 'package:flutter/material.dart';
import 'package:pomodoro_app/colors.dart';

class PomodoroCounter extends StatelessWidget {
  PomodoroCounter(
      {Key? key,
      required this.estimatedPomodoros,
      required this.increment,
      required this.decrement})
      : super(key: key);

  int estimatedPomodoros;
  final Function increment;
  final Function decrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PomodoroColors.color2,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: IconButton(
              icon:
                  const Icon(Icons.expand_more, color: Colors.white, size: 36),
              onPressed: () => decrement(--estimatedPomodoros),
            ),
          ),
          Expanded(
            child: Text(
              '$estimatedPomodoros',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 21,
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              icon: const Icon(
                Icons.expand_less,
                color: Colors.white,
                size: 36,
              ),
              onPressed: () => increment(++estimatedPomodoros),
            ),
          ),
        ],
      ),
    );
  }
}
