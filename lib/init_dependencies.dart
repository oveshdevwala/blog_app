// ignore_for_file: non_constant_identifier_names

import 'package:clean_architecture_tdd/core/commons/app_user_cubit/app_user_cubit.dart';
import 'package:clean_architecture_tdd/core/network/connection_checker.dart';
import 'package:clean_architecture_tdd/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architecture_tdd/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:clean_architecture_tdd/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_architecture_tdd/features/auth/domain/repositories/auth_repository.dart';
import 'package:clean_architecture_tdd/features/auth/domain/usecases/get_current_user_data.dart';
import 'package:clean_architecture_tdd/features/auth/domain/usecases/user_sign_in.dart';
import 'package:clean_architecture_tdd/features/auth/domain/usecases/user_sign_up.dart';
import 'package:clean_architecture_tdd/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:clean_architecture_tdd/features/blog/data/datasources/local/blog_local_data_source.dart';
import 'package:clean_architecture_tdd/features/blog/data/datasources/local/blog_local_data_source_impl.dart';
import 'package:clean_architecture_tdd/features/blog/data/datasources/remote/blog_remote_data_source.dart';
import 'package:clean_architecture_tdd/features/blog/data/datasources/remote/blog_remote_data_source_impl.dart';
import 'package:clean_architecture_tdd/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:clean_architecture_tdd/features/blog/domain/repositories/blog_repository.dart';
import 'package:clean_architecture_tdd/features/blog/domain/usecases/get_all_blog_usecase.dart';
import 'package:clean_architecture_tdd/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:clean_architecture_tdd/features/blog/presentation/bloc/get_all_blog_bloc/blog_bloc.dart';
import 'package:clean_architecture_tdd/features/blog/presentation/bloc/upload_bloc/upload_blog_bloc.dart';
import 'package:clean_architecture_tdd/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  _initBlog();

  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;
  serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogs'));
  var firebase = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
// Database Client

  //Firebase
  serviceLocator.registerLazySingleton(() => firebase);
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
  serviceLocator.registerLazySingleton(() => FirebaseStorage.instance.ref());
  // Hive

//Core
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator()));
}

void _initAuth() {
  serviceLocator
// Datasources
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(serviceLocator(), serviceLocator()))
// Repository
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(serviceLocator(), serviceLocator()))

// UseCase
    ..registerFactory(() => UserSignUpUseCase(serviceLocator()))
    ..registerFactory(() => UserSignInUsecase(serviceLocator()))
    ..registerFactory(
        () => GetCurrentUserDataUseCase(authRepository: serviceLocator()))
// Bloc
    ..registerLazySingleton(() => AuthBloc(
        appUserCubit: serviceLocator(),
        getCurrentUserDataUseCase: serviceLocator(),
        userSignUpUseCase: serviceLocator(),
        userSignInUsecase: serviceLocator()));
}

void _initBlog() {
  serviceLocator
    // DataSources
    ..registerFactory<BlogRemoteDataSource>(
        () => BlogRemoteDataSourceImpl(serviceLocator(), serviceLocator()))
    ..registerFactory<BlogLocalDataSource>(
        () => BlogLocalDataSourceImpl(serviceLocator()))
    // Repository
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
        serviceLocator(), serviceLocator(), serviceLocator()))

    // Usecase
    ..registerFactory(() => UploadBlogUseCase(serviceLocator()))
    ..registerFactory(() => GetAllBlogUseCase(serviceLocator()))
    // Bloc
    ..registerLazySingleton(() => BlogBloc(getAllBlogUseCase: serviceLocator()))
    ..registerLazySingleton(() => UploadBlogBloc(serviceLocator()));
}
