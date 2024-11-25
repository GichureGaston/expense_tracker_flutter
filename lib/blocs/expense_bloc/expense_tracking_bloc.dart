import 'package:equatable/equatable.dart';
import 'package:expense_tracker/expense_tracker/expense.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../network_config/network_client.dart';
import 'expense_tracking_state.dart';

part 'expense_tracking_event.dart';

class ExpenseTrackingBloc
    extends HydratedBloc<ExpenseTrackingEvent, ExpenseTrackingState> {
  ExpenseTrackingBloc() : super(const ExpenseTrackingState()) {
    on<ExpenseTrackerStarted>(_onStartExpense);
    on<ExpenseTrackerAdded>(_onAddExpense);
    on<ExpenseTrackerRemoved>(_onRemoveExpense);
    on<ExpenseTrackerUpdated>(_onUpdateExpense);
  }

  Future<void> _onStartExpense(
    ExpenseTrackerStarted event,
    Emitter<ExpenseTrackingState> emit,
  ) async {
    emit(state.copyWith(expenseTrackingStatus: ExpenseTrackingStatus.loading));
    final result = await _expensesHttpClient.getExpenses();
    emit(state.copyWith(
        expenseTracker: result,
        expenseTrackingStatus: ExpenseTrackingStatus.success));
  }

  Future<void> _onAddExpense(
    ExpenseTrackerAdded event,
    Emitter<ExpenseTrackingState> emit,
  ) async {
    emit(state.copyWith(expenseTrackingStatus: ExpenseTrackingStatus.loading));
    try {
      final result =
          await _expensesHttpClient.createExpense(event.expenseTracker);
      List<ExpenseTracker> temp = [];
      temp.addAll(state.expenseTracker ?? []);
      temp.add(result!);

      emit(state.copyWith(
          expenseTracker: temp.reversed.toList(),
          expenseTrackingStatus: ExpenseTrackingStatus.success));
    } catch (e) {
      emit(state.copyWith(
        expenseTrackingStatus: ExpenseTrackingStatus.error,
      ));
    }
  }

  void _onRemoveExpense(
    ExpenseTrackerRemoved event,
    Emitter<ExpenseTrackingState> emit,
  ) async {
    emit(state.copyWith(expenseTrackingStatus: ExpenseTrackingStatus.loading));
    try {
      await _expensesHttpClient.deleteExpense(event.expenseTracker);
      add(ExpenseTrackerStarted());
    } catch (e) {
      emit(state.copyWith(expenseTrackingStatus: ExpenseTrackingStatus.error));
    }
  }

  void _onUpdateExpense(
    ExpenseTrackerUpdated event,
    Emitter<ExpenseTrackingState> emit,
  ) async {
    emit(state.copyWith(expenseTrackingStatus: ExpenseTrackingStatus.loading));
    try {
      emit(state.copyWith(
          expenseTracker: state.expenseTracker,
          expenseTrackingStatus: ExpenseTrackingStatus.success));
    } catch (e) {
      emit(state.copyWith(expenseTrackingStatus: ExpenseTrackingStatus.error));
    }
  }

  @override
  ExpenseTrackingState? fromJson(Map<String, dynamic> json) {
    return ExpenseTrackingState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ExpenseTrackingState state) {
    // TODO: implement toJson
    return state.toJson();
  }

  final _expensesHttpClient = ExpensesHttpClient();
}
