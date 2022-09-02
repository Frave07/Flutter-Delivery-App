part of 'auth_bloc.dart';

@immutable
class AuthState {

  final User? user;
  final String rolId;

  const AuthState({
    this.user,
    this.rolId = ''
  });


  AuthState copyWith({ 
    User? user, 
    String? rolId 
  })=> AuthState(
    user: user ?? this.user,
    rolId: rolId ?? this.rolId 
  );
  
}

class LoadingAuthState extends AuthState {}

class SuccessAuthState extends AuthState {}

class LogOutAuthState extends AuthState {}

class FailureAuthState extends AuthState {
  final error;
  FailureAuthState(this.error);
}
