// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_architecture_tdd/core/error/failure.dart';
import 'package:clean_architecture_tdd/core/usecase/usecase.dart';
import 'package:clean_architecture_tdd/core/commons/entities/user_entitie.dart';
import 'package:clean_architecture_tdd/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignInUsecase implements UseCase<UserEntitie, SignInParam> {
  final AuthRepository authRepository;
  UserSignInUsecase(this.authRepository);
  @override
  Future<Either<Failure, UserEntitie>> call(SignInParam param) => authRepository
      .signInWithEmailPassword(email: param.email, password: param.password);
}

class SignInParam {
  String email;
  String password;
  SignInParam({
    required this.email,
    required this.password,
  });
}
