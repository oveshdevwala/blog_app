// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_architecture_tdd/core/error/failure.dart';
import 'package:clean_architecture_tdd/core/usecase/usecase.dart';
import 'package:clean_architecture_tdd/core/commons/entities/user_entitie.dart';
import 'package:clean_architecture_tdd/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUpUseCase implements UseCase<UserEntitie, SignUpParams> {
  final AuthRepository authRepository;

  UserSignUpUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserEntitie>> call(SignUpParams params) =>
      authRepository.signUpWithEmailPassword(
          name: params.name, email: params.email, password: params.password);
}

class SignUpParams {
  String name;
  String email;
  String password;
  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
