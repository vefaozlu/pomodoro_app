import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/colors.dart';
import 'package:pomodoro_app/model/repositories/repositories.dart';
import 'package:pomodoro_app/view_model/view_model.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const routeName = '/settingsPage';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: PomodoroColors.color1,
        appBar: AppBar(
          backgroundColor: PomodoroColors.color2,
          title: const Text('Settings'),
        ),
        body: BlocProvider(
          create: (context) => SettingsCubit(
              sR: context.read<SettingsRepository>(),
              dHR: context.read<DailyHistoryRepository>(),
              wHR: context.read<WeeklyHistoryRepository>())
            ..initializeSettings(),
          child: const SettingsView(),
        ),
      ),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) => Column(
        children: [
          SettingsField(
            title: 'Set Durations',
            tiles: [
              SettingTile(
                title: 'Study Duration: ${(state.studyDuration / 60).floor()}',
                actions: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: PomodoroColors.color3),
                    onPressed: () => context
                        .read<SettingsCubit>()
                        .onValueChange(studyDuration: state.studyDuration - 60),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: PomodoroColors.color3),
                    onPressed: () => context
                        .read<SettingsCubit>()
                        .onValueChange(studyDuration: state.studyDuration + 60),
                  ),
                ],
              ),
              SettingTile(
                title: 'Break Duration: ${(state.breakDuration / 60).floor()}',
                actions: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: PomodoroColors.color3),
                    onPressed: () => context
                        .read<SettingsCubit>()
                        .onValueChange(breakDuration: state.breakDuration - 60),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: PomodoroColors.color3),
                    onPressed: () => context
                        .read<SettingsCubit>()
                        .onValueChange(breakDuration: state.breakDuration + 60),
                  ),
                ],
              ),
            ],
          ),
          SettingsField(
            title: 'HistorySettings',
            tiles: [
              SettingTile(
                title: 'Clear History Data',
                actions: [
                  TextButton(
                    onPressed: () =>
                        context.read<SettingsCubit>().clearHistory(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: PomodoroColors.color3,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Clear',
                          style: TextStyle(
                            color: PomodoroColors.color2,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SettingsField(
            title: 'Theme Settings',
            tiles: [
              SettingTile(
                title: 'Dark Theme',
                actions: [
                  Switch(
                    activeColor: PomodoroColors.color3,
                    inactiveThumbColor: PomodoroColors.color1,
                    value: state.darkMode,
                    onChanged: (value) => context
                        .read<SettingsCubit>()
                        .onValueChange(darkMode: !state.darkMode),
                  ),
                ],
              ),
            ],
          ),
          MaterialButton(
            child: Container(
              decoration: BoxDecoration(
                color: PomodoroColors.color2,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: PomodoroColors.color3,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            onPressed: () {
              context.read<SettingsCubit>().saveChanges(
                  studyDuration: state.studyDuration,
                  breakDuration: state.breakDuration,
                  darkMode: state.darkMode);
              Navigator.pop(context);
              context.read<TimerBloc>().add(const InitializeTimer());
            },
          ),
        ],
      ),
    );
  }
}

class SettingsField extends StatelessWidget {
  const SettingsField({Key? key, required this.title, required this.tiles})
      : super(key: key);
  final String title;
  final List<SettingTile> tiles;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: PomodoroColors.color2,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: PomodoroColors.color3,
                  ),
                ),
              ),
            ),
            Column(mainAxisAlignment: MainAxisAlignment.end, children: tiles),
          ],
        ),
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  const SettingTile({Key? key, required this.title, required this.actions})
      : super(key: key);
  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, color: PomodoroColors.color3),
          ),
          const Spacer(),
          Row(children: actions),
        ],
      ),
    );
  }
}
