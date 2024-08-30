import 'package:clean_architecture_tdd/core/app_routes/app_routes.dart';
import 'package:clean_architecture_tdd/core/commons/app_user_cubit/app_user_cubit.dart';
import 'package:clean_architecture_tdd/core/theme/theme.dart';
import 'package:clean_architecture_tdd/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:clean_architecture_tdd/features/blog/presentation/bloc/get_all_blog_bloc/blog_bloc.dart';
import 'package:clean_architecture_tdd/features/blog/presentation/bloc/upload_bloc/upload_blog_bloc.dart';
import 'package:clean_architecture_tdd/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => serviceLocator<AppUserCubit>()),
      BlocProvider(create: (context) => serviceLocator<AuthBloc>()),
      BlocProvider(create: (context) => serviceLocator<BlogBloc>()),
      BlocProvider(create: (context) => serviceLocator<UploadBlogBloc>())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (_, child) {
      return MaterialApp(
          theme: AppTheme.darkThemeMode,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoute.isLogged,
          routes: AppRoute.routes);
    });
  }
}
