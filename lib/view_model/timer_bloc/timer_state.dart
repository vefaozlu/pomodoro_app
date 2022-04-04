part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  const TimerState(this.duration, this.timerForStudy);
  
  final int duration;
  final bool timerForStudy;

  @override
  List<Object> get props => [duration, timerForStudy];
}

class TimerLoading extends TimerState {
  const TimerLoading(int duration, bool timerForStudy) : super(duration, timerForStudy);
}

class TimerInitial extends TimerState {
  const TimerInitial(int duration, bool timerForStudy) : super(duration, timerForStudy);
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(int duration, bool timerForStudy) : super(duration, timerForStudy);
}

class TimerRunPause extends TimerState {
  const TimerRunPause(int duration, bool timerForStudy) : super(duration, timerForStudy);
}

class TimerRunCompleted extends TimerState {
  const TimerRunCompleted(int duration, bool timerForStudy) : super(duration, timerForStudy);
}
