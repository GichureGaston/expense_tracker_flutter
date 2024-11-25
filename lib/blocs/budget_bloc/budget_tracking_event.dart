part of 'budget_tracking_bloc.dart';

abstract class BudgetTrackingEvent extends Equatable {
  const BudgetTrackingEvent();

  @override
  List<Object?> get props => [];
}

class BudgetTrackingStarted extends BudgetTrackingEvent {}

class BudgetTrackingAdded extends BudgetTrackingEvent {
  final BudgetTracker? budgetTracker;

  const BudgetTrackingAdded(this.budgetTracker);
}

class BudgetTrackingRemoved extends BudgetTrackingEvent {
  final BudgetTracker? budgetTracker;

  const BudgetTrackingRemoved(this.budgetTracker);
}

class BudgetTrackingUpdated extends BudgetTrackingEvent {
  final int index;

  const BudgetTrackingUpdated(this.index);
}
