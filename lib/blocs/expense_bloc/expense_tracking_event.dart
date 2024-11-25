part of 'expense_tracking_bloc.dart';

abstract class ExpenseTrackingEvent extends Equatable {
  const ExpenseTrackingEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ExpenseTrackerStarted extends ExpenseTrackingEvent {}

class ExpenseTrackerAdded extends ExpenseTrackingEvent {
  final ExpenseTracker? expenseTracker;
  const ExpenseTrackerAdded(this.expenseTracker);
}

class ExpenseTrackerRemoved extends ExpenseTrackingEvent {
  final ExpenseTracker? expenseTracker;
  const ExpenseTrackerRemoved(this.expenseTracker);
}

class ExpenseTrackerUpdated extends ExpenseTrackingEvent {
  final int index;
  const ExpenseTrackerUpdated(this.index);
}
