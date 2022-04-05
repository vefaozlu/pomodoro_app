import 'package:flutter/material.dart';
import 'package:pomodoro_app/colors.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);
  static const routeName = '/supportPage';

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  int amount = 5;
  bool donateHappened = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: PomodoroColors.color1,
      appBar: AppBar(
        backgroundColor: PomodoroColors.color2,
        title: const Text('Support'),
      ),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: donateHappened
              ? Container(
                  height: size.height * .3,
                  width: size.width * .75,
                  decoration: BoxDecoration(
                    color: PomodoroColors.color2,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Thanks For Your Support',
                          style: TextStyle(
                            fontSize: 28,
                            color: PomodoroColors.color3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        MaterialButton(
                          child: Container(
                            width: size.width * .3,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: PomodoroColors.color3,
                            ),
                            child: const Center(
                              child: Text(
                                'Go Back',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: PomodoroColors.color1),
                              ),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  height: size.height * .5,
                  width: size.width * .75,
                  decoration: BoxDecoration(
                    color: PomodoroColors.color2,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Support Me',
                            style: TextStyle(
                              color: PomodoroColors.color3,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextButton(
                                    child: const Icon(Icons.expand_more,
                                        size: 42, color: PomodoroColors.color3),
                                    onPressed: () {
                                      if (amount > 0) {
                                        setState(() => amount -= 1);
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '$amount TL',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: PomodoroColors.color3,
                                      fontSize: 28,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextButton(
                                    child: const Icon(Icons.expand_less,
                                        size: 42, color: PomodoroColors.color3),
                                    onPressed: () =>
                                        setState(() => amount += 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: MaterialButton(
                              child: Container(
                                width: size.width * .3,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: PomodoroColors.color3,
                                ),
                                child: const Center(
                                  child: Text(
                                    'Donate!',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: PomodoroColors.color1),
                                  ),
                                ),
                              ),
                              onPressed: () => setState(
                                  () => donateHappened = !donateHappened),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
