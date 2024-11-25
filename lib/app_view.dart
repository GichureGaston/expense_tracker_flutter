import 'package:expense_tracker/authentication/authentication_blocs/authentication_bloc.dart';
import 'package:expense_tracker/authentication/views/welcome_screen.dart';
import 'package:expense_tracker/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ExpenseTracker',
        theme: ThemeData(
            colorScheme: ColorScheme.light(
          background: Colors.grey.shade100,
          onBackground: Colors.purple.shade700,
          primary: Colors.yellow.shade800,
          onPrimary: Colors.white,
        )),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: ((context, state) {
            if (state.authenticationStatus ==
                AuthenticationStatus.authenticated) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => AuthenticationBloc(),
                  ),
                ],
                child: HomeScreen(),
              );
            } else {
              return const WelcomeScreen();
            }
          }),
        ));
  }
}
