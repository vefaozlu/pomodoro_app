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
            border: InputBorder.none,
          ),
          validator: (value) => validator(value),
        ),
      ),
    );
  }
}
/* 
class Input extends StatefulWidget {
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
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigoAccent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextFormField(
          initialValue: widget.text,
          cursorColor: Colors.white,
          textAlign: TextAlign.center,
          maxLines: widget.maxLines,
          onChanged: (input) => widget.onChanged(input),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 21,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          validator: (value) => widget.validator(value),
        ),
      ),
    );
  }
}
 */