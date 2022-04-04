import 'package:flutter/material.dart';
import 'package:pomodoro_app/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage(
      {Key? key,
      required this.pushSettingsPage,
      required this.pushInformationPage,
      required this.pushSupportPage})
      : super(key: key);

  final VoidCallback pushSettingsPage;
  final VoidCallback pushInformationPage;
  final VoidCallback pushSupportPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PomodoroColors.color1,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: PomodoroColors.color2,
              radius: 75,
              child: Icon(Icons.person, size: 64, color: PomodoroColors.color3),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Kadir',
              style: TextStyle(fontSize: 28, color: PomodoroColors.color3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(
                  child: Text(
                    'Pmdrs Done\nThis Week\n5',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: PomodoroColors.color3),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Pmdrs Done\nThis Week\n5',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: PomodoroColors.color3),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Pmdrs Done\nThis Week\n5',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: PomodoroColors.color3),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          ProfilePagesButton(
            text: 'Settings',
            onPressed: () => pushSettingsPage(),
          ),
          ProfilePagesButton(
            text: 'Information',
            onPressed: () => pushInformationPage(),
          ),
          ProfilePagesButton(
            text: 'Support',
            onPressed: () => pushSupportPage(),
          ),
        ],
      ),
    );
  }
}

class ProfilePagesButton extends StatelessWidget {
  const ProfilePagesButton(
      {Key? key, required this.onPressed, required this.text})
      : super(key: key);

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.height * .9,
          decoration: BoxDecoration(
            color: PomodoroColors.color2,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: PomodoroColors.color3,
              ),
            ),
          ),
        ),
        onPressed: () => onPressed(),
      ),
    );
  }
}
