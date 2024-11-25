import 'package:expense_tracker/authentication/authentication_blocs/authentication_bloc.dart';
import 'package:expense_tracker/users/login_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {

  const MyApp( {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
     // create: (context) => AuthenticationBloc();
  }
}
