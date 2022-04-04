import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro_app/model/models/models.dart';
import 'package:pomodoro_app/model/repositories/repositories.dart';
import 'package:pomodoro_app/ticker/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static late int studyDuration;
  static late int breakDuration;

  Ticker _ticker;
  GoalsRepository _goalsRepository;
  SettingsRepository _settingsRepository;
  DailyHistoryRepository _dailyHistoryRepository;
  WeeklyHistoryRepository _weeklyHistoryRepository;

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc(
      {required Ticker ticker,
      required GoalsRepository gR,
      required SettingsRepository sR,
      required DailyHistoryRepository dHR,
      required WeeklyHistoryRepository wHR})
      : _ticker = ticker,
        _goalsRepository = gR,
        _settingsRepository = sR,
        _dailyHistoryRepository = dHR,
        _weeklyHistoryRepository = wHR,
        super(const TimerLoading(1500, true)) {
    on<InitializeTimer>(_onInitialize);
    on<StartNewSession>(_onStartNewSession);
    on<StartTimer>(_onStarted);
    on<PauseTimer>(_onPause);
    on<ResetTimer>(_onReset);
    on<SkipSession>(_onSkipSession);
    on<ExtendSession>(_onExtendSession);
    on<_TimerTicked>(_onTicked);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Future<void> _onInitialize(TimerEvent event, Emitter<TimerState> emit) async {
    await _settingsRepository.initialize();
    final Settings settings = _settingsRepository.fetchItems();
    studyDuration = settings.studyDuration;
    breakDuration = settings.breakDuration;
    emit(TimerInitial(studyDuration, true));
  }

  void _onStartNewSession(StartNewSession event, Emitter<TimerState> emit) {
    emit(TimerInitial(event.timerForStudy ? studyDuration : breakDuration,
        event.timerForStudy));
  }

  void _onStarted(StartTimer event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(state.duration)
        .listen((duration) => add(_TimerTicked(duration)));
  }

  void _onPause(PauseTimer event, Emitter<TimerState> emit) {
    _tickerSubscription?.pause();
    emit(TimerRunPause(event.duration, state.timerForStudy));
  }

  void _onReset(ResetTimer event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(TimerInitial(state.timerForStudy ? studyDuration : breakDuration,
        state.timerForStudy));
  }

  void _onSkipSession(SkipSession event, Emitter<TimerState> emit) {
    add(const _TimerTicked(0));
  }

  void _onExtendSession(ExtendSession event, Emitter<TimerState> emit) {
    final int extendedDuration = state.duration + event.durationToExtend;
    add(_TimerTicked(extendedDuration));
  }

  Future<void> _onTicked(_TimerTicked event, Emitter<TimerState> emit) async {
    if (event.duration > 0) {
      emit(TimerRunInProgress(event.duration, state.timerForStudy));
    } else {
      _tickerSubscription?.cancel();
      if (state.timerForStudy) {
        await _incrementPomodorosDone();
/*         final currentGoal = _goalsRepository.fetchCurrentItem();
        if(currentGoal!.estimatedPomodoros == currentGoal.pomodorosDone) {
          _goalsRepository.deleteItem(id: currentGoal.id);
        } */
      }
      emit(TimerRunCompleted(0, state.timerForStudy));
    }
  }

  Future<void> _incrementPomodorosDone() async {
    final currentGoalName = _goalsRepository.fetchCurrentItem()!.name;

    await _goalsRepository.incrementPomodorosDone();
    await _dailyHistoryRepository.incrementPomodorosDone(currentGoalName);
    await _weeklyHistoryRepository.incrementPomodorosDone();
  }
}
