import 'package:equatable/equatable.dart';
import 'package:expense_tracker/expense_tracker/expense.dart';

enum ExpenseTrackingStatus { initial, loading, success, error }

class ExpenseTrackingState extends Equatable {
  final List<ExpenseTracker>? expenseTracker;
  final ExpenseTrackingStatus expenseTrackingStatus;

  const ExpenseTrackingState(
      {this.expenseTracker,
      this.expenseTrackingStatus = ExpenseTrackingStatus.initial});

  ExpenseTrackingState copyWith({
    ExpenseTrackingStatus? expenseTrackingStatus,
    List<ExpenseTracker>? expenseTracker,
  }) {
    return ExpenseTrackingState(
        expenseTracker: expenseTracker ?? this.expenseTracker,
        expenseTrackingStatus:
            expenseTrackingStatus ?? this.expenseTrackingStatus);
  }

  @override
  factory ExpenseTrackingState.fromJson(Map<String, dynamic> json) {
    try {
      var listOfExpenses = (json['expenseTracker'] as List<dynamic>)
          .map((e) => ExpenseTracker.fromJson(e as Map<String, dynamic>))
          .toList();
      return ExpenseTrackingState(
          expenseTracker: listOfExpenses,
          expenseTrackingStatus: ExpenseTrackingStatus.values.firstWhere(
              (element) =>
                  element.name.toString() == json['expenseTrackingStatus']));
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'expenseTracker': expenseTracker,
      'name': expenseTrackingStatus.name,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [expenseTracker, expenseTrackingStatus];
}
