part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthModel authModel;
  AuthSuccess({required this.authModel});
}

class AuthFailed extends AuthState {
  final String message;
  AuthFailed({required this.message});
}
