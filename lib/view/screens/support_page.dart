import 'package:flutter/material.dart';
import 'package:pomodoro_app/colors.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({ Key? key }) : super(key: key);
  static const routeName = 'supportPage';
  
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: PomodoroColors.color1,
      body: Center(
        child: Container(
          height: size.height * .5,
          width: size.width * .75,
          decoration: BoxDecoration(
            color: PomodoroColors.color2,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}