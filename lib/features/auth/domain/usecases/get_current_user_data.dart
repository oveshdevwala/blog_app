import 'package:clean_architecture_tdd/core/error/failure.dart';
import 'package:clean_architecture_tdd/core/commons/entities/user_entitie.dart';
import 'package:clean_architecture_tdd/core/usecase/usecase.dart';
import 'package:clean_architecture_tdd/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUserDataUseCase implements UseCase<UserEntitie,NoParams> {
  final AuthRepository authRepository;
  GetCurrentUserDataUseCase({
    required this.authRepository,
  });
  Future<Either<Failure, UserEntitie>> call(NoParams NoParams) async =>
      await authRepository.getCurrentUserData();
}
