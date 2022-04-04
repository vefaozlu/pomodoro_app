part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class InitializeTimer extends TimerEvent {
  const InitializeTimer();
}

class StartNewSession extends TimerEvent {
  const StartNewSession(this.timerForStudy);

  final bool timerForStudy;

  @override
  List<Object> get props => [timerForStudy];
}

class StartTimer extends TimerEvent {
  const StartTimer(this.duration, this.timerForStudy);

  final int duration;
  final bool timerForStudy;

  @override
  List<Object> get props => [duration, timerForStudy];
}

class PauseTimer extends TimerEvent {
  const PauseTimer(this.duration);

  final int duration;

  @override
  List<Object> get props => [duration];
}

class ResetTimer extends TimerEvent {
  const ResetTimer();
}

class SkipSession extends TimerEvent {
  const SkipSession(this.timerForStudy);

  final bool timerForStudy;

  @override
  List<Object> get props => [timerForStudy];
}

class ExtendSession extends TimerEvent {
  const ExtendSession(this.durationToExtend);

  final int durationToExtend;

  @override
  List<Object> get props => [durationToExtend];
}

class _TimerTicked extends TimerEvent {
  const _TimerTicked(this.duration);

  final int duration;

  @override
  List<Object> get props => [duration];
}
