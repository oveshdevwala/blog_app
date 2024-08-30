import 'package:clean_architecture_tdd/core/commons/entities/user_entitie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitialState());

  void updateUser(UserEntitie? user) {
    if (user == null) {
      // print(user);
      print('user is null');
       emit(AppUserLoggedOutState(message: 'User Not Founded In AppUserCubit'));
    } else {
      emit(AppUserLoggedInState(user));
    }
  }

}
