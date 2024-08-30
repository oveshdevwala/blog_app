// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_architecture_tdd/core/error/exception.dart';
import 'package:clean_architecture_tdd/core/error/failure.dart';
import 'package:clean_architecture_tdd/core/network/connection_checker.dart';
import 'package:clean_architecture_tdd/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architecture_tdd/core/commons/entities/user_entitie.dart';
import 'package:clean_architecture_tdd/features/auth/data/models/user_model.dart';
import 'package:clean_architecture_tdd/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);
  @override
  Future<Either<Failure, UserEntitie>> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure('No Internet Connection'));
      }
      final user = await remoteDataSource.signInWithEmailPassword(
          email: email, password: password);

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }on FirebaseAuthException catch(e){
      return left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, UserEntitie>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure('No Internet Connection'));
      }
      final user = await remoteDataSource.signUpWithEmailPassword(
          email: email, password: password, name: name);

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }on FirebaseAuthException catch(e){
      return left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, UserEntitie>> getCurrentUserData() async {
    try {
      // if (!await (connectionChecker.isConnected)) {
      //   return left(Failure('No Internet Connection'));
      // }
      UserModel? user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        print('Failure(Your Not LoggedIn)');
        return left(Failure('Your Not LoggedIn'));
        // return right(user!);
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
