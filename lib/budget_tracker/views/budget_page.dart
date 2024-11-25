import 'package:expense_tracker/blocs/budget_bloc/budget_tracking_bloc.dart';
import 'package:expense_tracker/blocs/budget_bloc/budget_tracking_state.dart';
import 'package:expense_tracker/budget_tracker/budget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key, this.budgetTracker});

  final BudgetTracker? budgetTracker;

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'BUDGET TRACKER',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocProvider(
        create: (context) => BudgetTrackingBloc()..add(BudgetTrackingStarted()),
        child: RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<BudgetTrackingBloc>(context)
                  .add(BudgetTrackingStarted());
            },
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: BlocBuilder<BudgetTrackingBloc, BudgetTrackingState>(
                  builder: (context, state) {
                if (state.budgetTrackingStatus ==
                    BudgetTrackingStatus.success) {
                  return ListView.builder(
                      itemCount: state.budgetTracker?.length,
                      itemBuilder: (context, int i) {
                        return Card(
                          color: Colors.white60,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          BudgetPage(
                                            budgetTracker:
                                                state.budgetTracker?[i],
                                          )));
                            },
                            title: Text(state.budgetTracker?[i].name ?? ""),
                            subtitle:
                                Text(state.budgetTracker?[i].createdAt ?? ""),
                            trailing: Column(
                              children: [
                                Text(
                                    state.budgetTracker?[i].amount.toString() ??
                                        "")
                              ],
                            ),
                          ),
                        );
                      });
                } else if (state.budgetTrackingStatus ==
                    BudgetTrackingStatus.initial) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Container();
                }
              }),
            )),
      ),
    );
  }
}
