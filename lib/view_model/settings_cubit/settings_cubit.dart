import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro_app/model/models/models.dart';
import 'package:pomodoro_app/model/repositories/repositories.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _settingsRepository;
  final DailyHistoryRepository _dailyHistoryRepository;
  final WeeklyHistoryRepository _weeklyHistoryRepository;
  SettingsCubit(
      {required SettingsRepository sR,
      required DailyHistoryRepository dHR,
      required WeeklyHistoryRepository wHR})
      : _settingsRepository = sR,
        _dailyHistoryRepository = dHR,
        _weeklyHistoryRepository = wHR,
        super(const SettingsState());

  void initializeSettings() {
    final Settings settings = _settingsRepository.fetchItems();
    emit(SettingsState(
        studyDuration: settings.studyDuration,
        breakDuration: settings.breakDuration));
  }

  void onValueChange({int? studyDuration, int? breakDuration, bool? darkMode}) {
    emit(SettingsState(
      studyDuration: studyDuration ?? state.studyDuration,
      breakDuration: breakDuration ?? state.breakDuration,
      darkMode: darkMode ?? state.darkMode,
    ));
  }

  Future<void> clearHistory() async {
    await _dailyHistoryRepository.clear();
    await _weeklyHistoryRepository.clear();
  }

  Future<void> saveChanges(
      {required int studyDuration,
      required int breakDuration,
      required bool darkMode}) async {
    await _settingsRepository.changeSettings(
        studyDuration: studyDuration, breakDuration: breakDuration);
  }
}
