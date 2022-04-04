part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState(
      {this.studyDuration = 1500,
      this.breakDuration = 300,
      this.darkMode = true});

  final int studyDuration;
  final int breakDuration;
  final bool darkMode;

  @override
  List<Object> get props => [studyDuration, breakDuration, darkMode];
}
