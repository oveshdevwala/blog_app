// ignore_for_file: unused_field

import 'package:clean_architecture_tdd/core/commons/app_user_cubit/app_user_cubit.dart';
import 'package:clean_architecture_tdd/core/commons/entities/user_entitie.dart';
import 'package:clean_architecture_tdd/core/usecase/usecase.dart';
import 'package:clean_architecture_tdd/features/auth/domain/usecases/get_current_user_data.dart';
import 'package:clean_architecture_tdd/features/auth/domain/usecases/user_sign_in.dart';
import 'package:clean_architecture_tdd/features/auth/domain/usecases/user_sign_up.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUseCase _userSignUpUseCase;
  final UserSignInUsecase _userSignInUseCase;
  final GetCurrentUserDataUseCase _currentUserDataUseCase;
  final AppUserCubit _appUserCubit;
  AuthBloc(
      {required UserSignUpUseCase userSignUpUseCase,
      required GetCurrentUserDataUseCase getCurrentUserDataUseCase,
      required UserSignInUsecase userSignInUsecase,
      required AppUserCubit appUserCubit})
      : _userSignUpUseCase = userSignUpUseCase,
        _userSignInUseCase = userSignInUsecase,
        _currentUserDataUseCase = getCurrentUserDataUseCase,
        _appUserCubit = appUserCubit,
        super(AuthInitialState()) {
    // on<AuthEvent>(
    //   (_, emit) => emit(AuthLoadingState()),
    // );
    on<AuthSignUpEvent>(_authSignUpEvent);
    on<AuthSignInEvent>(_authSignInEvent);
    on<IsUserLoggedInEvent>(_isUserLoggedInEvent);
  }

  void _authSignUpEvent(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final res = await _userSignUpUseCase.call(SignUpParams(
          name: event.name, email: event.email, password: event.password));

      res.fold(
        (e) => emit(AuthFailureState(errorMsg: e.message)),
        (user) => _emitAuthSuccess(user, emit),
      );
    } catch (e) {
      emit(AuthFailureState(errorMsg: e.toString()));
    }
  }

  void _authSignInEvent(AuthSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final res = await _userSignInUseCase
          .call(SignInParam(email: event.email, password: event.password));
      res.fold(
        (e) => emit(AuthFailureState(errorMsg: e.message)),
        (user) => _emitAuthSuccess(user, emit),
      );
    } catch (e) {
      emit(AuthFailureState(errorMsg: e.toString()));
    }
  }

  void _isUserLoggedInEvent(
      IsUserLoggedInEvent event, Emitter<AuthState> emit) async {
    
      final res = await _currentUserDataUseCase.call(NoParams());
      res.fold(
        (e) => _appUserCubit.updateUser(null),
        (user) => _emitAuthSuccess(user, emit),
      );
  
  }


  void _emitAuthSuccess(UserEntitie? user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthLoadedState(user!));
  }
}
