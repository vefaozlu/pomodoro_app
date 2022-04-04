part of 'history_cubit.dart';

enum HistoryStatus { loading, success, failure }

class HistoryState extends Equatable {
  const HistoryState._({
    this.status = HistoryStatus.loading,
    this.dailyHistory = const [],
    this.weeklyHistory = const [],
    this.leastStudiedDay = '',
    this.mostStudiedDay = '',
    this.leastStudiedLesson = null,
    this.mostStudiedLesson = null,
    this.totalPomodoros = 0,
  });

  const HistoryState.loading() : this._(status: HistoryStatus.loading);

  const HistoryState.success(
    List<DailyHistory> dailyHistory,
    List<WeeklyHistory> weeklyHistory,
    String leastStudiedDay,
    String mostStudiedDay,
    DailyHistory? leastStudiedLesson,
    DailyHistory? mostStudiedLesson,
    int totalPomodoros,
  ) : this._(
          status: HistoryStatus.success,
          dailyHistory: dailyHistory,
          weeklyHistory: weeklyHistory,
          leastStudiedDay: leastStudiedDay,
          mostStudiedDay: mostStudiedDay,
          leastStudiedLesson: leastStudiedLesson,
          mostStudiedLesson: mostStudiedLesson,
          totalPomodoros: totalPomodoros,
        );

  const HistoryState.failure() : this._(status: HistoryStatus.failure);

  final HistoryStatus status;
  final List<DailyHistory> dailyHistory;
  final List<WeeklyHistory> weeklyHistory;
  final String mostStudiedDay;
  final String leastStudiedDay;
  final DailyHistory? leastStudiedLesson;
  final DailyHistory? mostStudiedLesson;
  final int totalPomodoros;

  @override
  List<Object?> get props => [
        status,
        dailyHistory,
        weeklyHistory,
        leastStudiedDay,
        mostStudiedDay,
        leastStudiedLesson,
        mostStudiedLesson,
        totalPomodoros
      ];
}
