part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}
class RegisterLoadingState extends AuthState {}
class RegisterSuccessState extends AuthState {}
class FailedToRegisterState extends AuthState {
  String message;
  FailedToRegisterState({required this.message});
}

class GlobalLoadingState extends AuthState {}
class GlobalSuccessState extends AuthState {}
class FailedToGlobalState extends AuthState {
  String message;
  FailedToGlobalState({required this.message});
}

class LoginLoadingState extends AuthState {}
class LoginSuccessState extends AuthState {
  String message;
  LoginSuccessState({required this.message});}
class FailedToLoginState extends AuthState {
  String message;
  FailedToLoginState({required this.message});
}

class ForgetLoadingState extends AuthState {}
class ForgetSuccessState extends AuthState {}
class FailedToForgetState extends AuthState {
  String message;
  FailedToForgetState({required this.message});
}

