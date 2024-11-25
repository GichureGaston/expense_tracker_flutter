import 'package:equatable/equatable.dart';
import 'package:expense_tracker/budget_tracker/budget.dart';

enum BudgetTrackingStatus { initial, loading, success, error }

class BudgetTrackingState extends Equatable {
  final List<BudgetTracker>? budgetTracker;
  final BudgetTrackingStatus budgetTrackingStatus;

  const BudgetTrackingState(
      {this.budgetTracker,
      this.budgetTrackingStatus = BudgetTrackingStatus.initial});

  BudgetTrackingState copyWith({
    BudgetTrackingStatus? budgetTrackingStatus,
    List<BudgetTracker>? budgetTracker,
  }) {
    return BudgetTrackingState(
        budgetTracker: budgetTracker ?? this.budgetTracker,
        budgetTrackingStatus:
            budgetTrackingStatus ?? this.budgetTrackingStatus);
  }

  factory BudgetTrackingState.fromJson(Map<String, dynamic> json) {
    try {
      var listOfBudgets = (json['budgetTracker'] as List<dynamic>)
          .map((e) => BudgetTracker.fromJson(e as Map<String, dynamic>))
          .toList();

      return BudgetTrackingState(
          budgetTracker: listOfBudgets,
          budgetTrackingStatus: BudgetTrackingStatus.values.firstWhere(
              (element) =>
                  element.name.toString() == json['budgetTrackingStatus']));
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'budgetTracker': budgetTracker,
      'name': budgetTrackingStatus.name,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [budgetTracker, budgetTrackingStatus];
}
