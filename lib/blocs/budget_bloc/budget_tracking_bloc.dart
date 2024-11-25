import 'package:equatable/equatable.dart';
import 'package:expense_tracker/budget_tracker/budget.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../network_config/network_client.dart';
import 'budget_tracking_state.dart';

part 'budget_tracking_event.dart';

class BudgetTrackingBloc
    extends HydratedBloc<BudgetTrackingEvent, BudgetTrackingState> {
  BudgetTrackingBloc() : super(const BudgetTrackingState()) {
    on<BudgetTrackingStarted>(_onStartBudget);
    on<BudgetTrackingAdded>(_onAddBudget);
    on<BudgetTrackingRemoved>(_onRemoveBudget);
    on<BudgetTrackingUpdated>(_onUpdateBudget);
  }

  void _onStartBudget(
    BudgetTrackingStarted event,
    Emitter<BudgetTrackingState> emit,
  ) async {
    emit(state.copyWith(budgetTrackingStatus: BudgetTrackingStatus.loading));
    final result = await _budgetHttpsClient.getBudgets();
    emit(state.copyWith(
        budgetTracker: result,
        budgetTrackingStatus: BudgetTrackingStatus.success));
  }

  void _onAddBudget(
    BudgetTrackingAdded event,
    Emitter<BudgetTrackingState> emit,
  ) async {
    emit(state.copyWith(budgetTrackingStatus: BudgetTrackingStatus.loading));
    try {
      final result = await _budgetHttpsClient.createBudget(event.budgetTracker);
      List<BudgetTracker> temp = [];
      temp.addAll(state.budgetTracker ?? []);
      temp.add(result!);
      emit(state.copyWith(
          budgetTracker: temp.reversed.toList(),
          budgetTrackingStatus: BudgetTrackingStatus.success));
    } catch (e) {
      emit(state.copyWith(
        budgetTrackingStatus: BudgetTrackingStatus.error,
      ));
    }
  }

  void _onRemoveBudget(
    BudgetTrackingRemoved event,
    Emitter<BudgetTrackingState> emit,
  ) async {
    emit(state.copyWith(budgetTrackingStatus: BudgetTrackingStatus.loading));

    try {
      await _budgetHttpsClient.deleteBudgetTracker(event.budgetTracker);
      add(BudgetTrackingStarted());
    } catch (e) {
      emit(state.copyWith(budgetTrackingStatus: BudgetTrackingStatus.error));
    }
  }

  void _onUpdateBudget(
    BudgetTrackingUpdated event,
    Emitter<BudgetTrackingState> emit,
  ) async {
    emit(state.copyWith(budgetTrackingStatus: BudgetTrackingStatus.loading));
    try {
      emit(state.copyWith(
          budgetTracker: state.budgetTracker,
          budgetTrackingStatus: BudgetTrackingStatus.success));
    } catch (e) {
      emit(state.copyWith(budgetTrackingStatus: BudgetTrackingStatus.error));
    }
  }

  @override
  BudgetTrackingState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return BudgetTrackingState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(BudgetTrackingState state) {
    // TODO: implement toJson
    return state.toJson();
  }

  final _budgetHttpsClient = BudgetHttpClient();
}
