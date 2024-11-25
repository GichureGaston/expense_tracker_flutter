part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object?> get props => [];
}

class CheckAuthenticationStatus extends AuthenticationEvent {}

class RegisterEvent extends AuthenticationEvent {
  final RegisterUser? registerUser;
  const RegisterEvent(this.registerUser);
}

class LoginEvent extends AuthenticationEvent {
  final LoginUser? loginUser;
  const LoginEvent(this.loginUser);
}
