import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro_app/model/models/models.dart';
import 'package:pomodoro_app/model/repositories/repositories.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final DailyHistoryRepository _dailyHistoryRepository;
  final WeeklyHistoryRepository _weeklyHistoryRepository;
  HistoryCubit(
      {required DailyHistoryRepository dHR,
      required WeeklyHistoryRepository wHR})
      : _dailyHistoryRepository = dHR,
        _weeklyHistoryRepository = wHR,
        super(const HistoryState.loading());

  Future<void> fetchItems() async {
    final List<DailyHistory> dailyHistoryItems;
    final List<WeeklyHistory> weeklyHistoryItems;
    final String leastStudiedDay;
    final String mostStudiedDay;
    final DailyHistory? leastStudiedLesson;
    final DailyHistory? mostStudiedLesson;
    final int totalPomodoros;

    dailyHistoryItems = _dailyHistoryRepository.fetcItems();
    weeklyHistoryItems = _weeklyHistoryRepository.fetchItems();
    leastStudiedDay = _weeklyHistoryRepository.fetchLeastStudied();
    mostStudiedDay = _weeklyHistoryRepository.fetchMostStudied();
    leastStudiedLesson = _dailyHistoryRepository.fetchLeastStudied();
    mostStudiedLesson = _dailyHistoryRepository.fetchMostStudied();

    int total = 0;
    for (int i = 0; i < dailyHistoryItems.length; i++) {
      total += dailyHistoryItems[i].pomodorosDone;
    }
    totalPomodoros = total;

    emit(HistoryState.success(
        dailyHistoryItems,
        weeklyHistoryItems,
        leastStudiedDay,
        mostStudiedDay,
        leastStudiedLesson,
        mostStudiedLesson,
        totalPomodoros));
  }
}
