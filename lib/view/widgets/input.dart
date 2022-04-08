import 'package:flutter/material.dart';
import 'package:pomodoro_app/colors.dart';

class Input extends StatelessWidget {
  const Input(
      {Key? key,
      this.text,
      this.controller,
      required this.maxLines,
      required this.validator,
      required this.onChanged})
      : super(key: key);

        final String? text;
  final TextEditingController? controller;
  final int maxLines;
  final Function validator;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PomodoroColors.color2,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextFormField(
          initialValue: text,
          cursorColor: Colors.white,
          textAlign: TextAlign.center,
          maxLines: maxLines,
          onChanged: (input) => onChanged(input),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 21,
          ),
          decoration: const InputDecoration(
            errorStyle: TextStyle(color: PomodoroColors.color3),
            border: InputBorder.none,
          ),
          validator: (value) => validator(value),
        ),
      ),
    );
  }
}