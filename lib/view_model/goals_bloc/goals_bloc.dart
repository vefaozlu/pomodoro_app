import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro_app/model/models/models.dart';
import 'package:pomodoro_app/model/repositories/repositories.dart';

part 'goals_event.dart';
part 'goals_state.dart';

class GoalsBloc extends Bloc<GoalsEvent, GoalsState> {
  final GoalsRepository _repository;
  final DailyHistoryRepository _dailyHistoryRepository;
  GoalsBloc(
      {required GoalsRepository repository,
      required DailyHistoryRepository dHR})
      : _repository = repository,
        _dailyHistoryRepository = dHR,
        super(const GoalsLoading()) {
    on<FetchItems>(_onFetchItems);
    on<DeleteGoal>(_onDeleteGoal);
    on<ChangeCurrentGoal>(_onChangeCurrentGoal);
  }

  Future<void> _onFetchItems(FetchItems event, Emitter<GoalsState> emit) async {
    await _repository.initialize();
    await _dailyHistoryRepository.initialize();
    final List<Goal> goals;
    final Goal? currentGoal;
    goals = _repository.fetchItems();
    currentGoal = _repository.fetchCurrentItem();
    emit(GoalsSuccess(goals: goals, currentGoal: currentGoal));
  }

  Future<void> _onDeleteGoal(DeleteGoal event, Emitter<GoalsState> emit) async {
    final List<Goal> goals;
    await _repository.deleteItem(id: event.goalToDelete.id);
    add(const FetchItems());
  }

/*   void _onGoalInputStarted(GoalInputStarted event, Emitter<GoalsState> emit) {
    emit(GoalInputInProgress(goalToEdit: event.goalToEdit));
  } */

  Future<void> _onChangeCurrentGoal(
      ChangeCurrentGoal event, Emitter<GoalsState> emit) async {
    _repository.changeCurrentItem(id: event.newCurrentGoal.id);
    add(const FetchItems());
  }
}
