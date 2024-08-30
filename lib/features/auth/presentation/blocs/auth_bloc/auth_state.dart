// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoadedState extends AuthState {
  final UserEntitie userModel;
  const AuthLoadedState(this.userModel);
}

class AuthFailureState extends AuthState {
  String errorMsg;
  AuthFailureState({
    required this.errorMsg,
  });
}
