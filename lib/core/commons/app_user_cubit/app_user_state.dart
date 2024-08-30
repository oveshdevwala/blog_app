// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'app_user_cubit.dart';

sealed class AppUserState extends Equatable {
  const AppUserState();

  @override
  List<Object> get props => [];
}

final class AppUserInitialState extends AppUserState {}

class AppUserLoggedInState extends AppUserState {
  final UserEntitie? userEntitie;
// Core Cannot Depends on other Features
// but Other Features Depends on Core
// That why entities folder in Core
  const AppUserLoggedInState(this.userEntitie);
}

class AppUserLoggedOutState extends AppUserState {
  String message;
  AppUserLoggedOutState({
    required this.message,
  });
  
}
