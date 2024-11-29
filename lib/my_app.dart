import 'package:expense_tracker/app_view.dart';
import 'package:expense_tracker/authentication/authentication_blocs/authentication_bloc.dart';
import 'package:expense_tracker/blocs/budget_bloc/budget_tracking_bloc.dart';
import 'package:expense_tracker/blocs/expense_bloc/expense_tracking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExpenseTrackingBloc>(
          create: (context) => ExpenseTrackingBloc(),
        ),
        BlocProvider<BudgetTrackingBloc>(
          create: (context) => BudgetTrackingBloc(),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(),
        ),
      ],
      child: const MyAppView(),
    );
  }
}
