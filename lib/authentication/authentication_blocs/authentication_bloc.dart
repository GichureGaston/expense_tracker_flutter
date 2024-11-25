import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/authentication/register_user.dart';
import 'package:expense_tracker/network_config/network_client.dart';
import 'package:expense_tracker/users/login_user.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc()
      : super(const AuthenticationState._(
          authenticationStatus: AuthenticationStatus.initial,
          errorMessage: '',
        )) {
    on<CheckAuthenticationStatus>(_onCheckAuthenticationStatus);
    on<RegisterEvent>(_onRegisterEvent);
    on<LoginEvent>(_onLoginEvent);
  }

  Future<void> _onCheckAuthenticationStatus(CheckAuthenticationStatus event,
      Emitter<AuthenticationState> emit) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final jwt = prefs.getString("jwt");

      if (jwt != null) {
        emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.authenticated,
        ));
      } else {
        emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.unauthenticated,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        authenticationStatus: AuthenticationStatus.unauthenticated,
        errorMessage: "Failed to check authentication status: $e",
      ));
    }
  }

  Future<void> _onRegisterEvent(
      RegisterEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));
    try {
      final result = await _registerHttpsClient.createUser(event.registerUser);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("jwt", result.access ?? '');

      emit(state.copyWith(
        authenticationStatus: AuthenticationStatus.authenticated,
      ));
    } catch (e) {
      emit(state.copyWith(
        authenticationStatus: AuthenticationStatus.unauthenticated,
        errorMessage: "Registration failed: $e",
      ));
    }
  }

  Future<void> _onLoginEvent(
      LoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));
    try {
      final result =
          await _loginHttpsClient.createUser(event.loginUser as LoginUser?);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("jwt", result?.access ?? '');

      emit(state.copyWith(
        authenticationStatus: AuthenticationStatus.authenticated,
      ));
    } catch (e) {
      emit(state.copyWith(
        authenticationStatus: AuthenticationStatus.unauthenticated,
        errorMessage: "Login failed: $e",
      ));
    }
  }

  final _registerHttpsClient = RegisterHttpsClient();
  final _loginHttpsClient = LoginHttpsClient();
}
