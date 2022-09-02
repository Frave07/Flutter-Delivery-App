part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}


class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}


class CheckLoginEvent extends AuthEvent {}


class LogOutEvent extends AuthEvent {}




