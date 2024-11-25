part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  initial,
  loading,
}

class AuthenticationState extends Equatable {
  final AuthenticationStatus authenticationStatus;
  final String errorMessage;

  const AuthenticationState({
    this.authenticationStatus = AuthenticationStatus.initial,
    this.errorMessage = '',
  });

  // Named private constructor for advanced usage
  const AuthenticationState._({
    required this.authenticationStatus,
    required this.errorMessage,
  });

  AuthenticationState copyWith({
    AuthenticationStatus? authenticationStatus,
    String? errorMessage,
  }) {
    return AuthenticationState(
      authenticationStatus: authenticationStatus ?? this.authenticationStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory AuthenticationState.fromJson(Map<String, dynamic> json) {
    return AuthenticationState(
      authenticationStatus: AuthenticationStatus.values.firstWhere(
        (element) => element.name == json['authenticationStatus'],
        orElse: () => AuthenticationStatus.initial,
      ),
      errorMessage: json['errorMessage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authenticationStatus': authenticationStatus.name,
      'errorMessage': errorMessage,
    };
  }

  @override
  List<Object?> get props => [authenticationStatus, errorMessage];
}
