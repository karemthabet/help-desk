part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
class AuthLoggedIn extends AuthState {
  final Map<String, dynamic>? profile;
  AuthLoggedIn(this.profile);
}
