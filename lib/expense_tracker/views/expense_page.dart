import 'package:expense_tracker/blocs/expense_bloc/expense_tracking_bloc.dart';
import 'package:expense_tracker/blocs/expense_bloc/expense_tracking_state.dart';
import 'package:expense_tracker/expense_tracker/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key, this.expenseTracker});

  final ExpenseTracker? expenseTracker;

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'EXPENSE TRACKER',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w600),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<ExpenseTrackingBloc>(context)
              .add(ExpenseTrackerStarted());
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<ExpenseTrackingBloc, ExpenseTrackingState>(
            builder: (context, state) {
              if (state.expenseTrackingStatus ==
                  ExpenseTrackingStatus.success) {
                return ListView.builder(
                  itemCount: state.expenseTracker?.length ?? 0,
                  itemBuilder: (context, int i) {
                    return Card(
                      color: Colors.white70,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => ExpensePage(
                                expenseTracker: state.expenseTracker?[i],
                              ),
                            ),
                          );
                        },
                        title: Text(state.expenseTracker?[i].name ?? ""),
                        subtitle:
                            Text(state.expenseTracker?[i].createdAt ?? ""),
                        trailing: Column(
                          children: [
                            Text(state.expenseTracker?[i].amount.toString() ??
                                ""),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (state.expenseTrackingStatus ==
                  ExpenseTrackingStatus.initial) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
