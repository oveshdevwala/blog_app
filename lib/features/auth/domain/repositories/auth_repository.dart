import 'package:clean_architecture_tdd/core/error/failure.dart';
import 'package:clean_architecture_tdd/core/commons/entities/user_entitie.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure,UserEntitie>> signUpWithEmailPassword(
      {required String name, required String email, required String password});

  Future<Either<Failure,UserEntitie>> signInWithEmailPassword(
      {required String email, required String password});
  Future<Either<Failure, UserEntitie>> getCurrentUserData();
}
