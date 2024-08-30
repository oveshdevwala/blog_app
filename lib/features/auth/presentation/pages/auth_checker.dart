// import 'dart:async';

import 'dart:async';

import 'package:clean_architecture_tdd/core/app_routes/app_routes.dart';
import 'package:clean_architecture_tdd/core/commons/app_user_cubit/app_user_cubit.dart';
import 'package:clean_architecture_tdd/core/theme/app_pallete.dart';
import 'package:clean_architecture_tdd/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AuthenticatePage extends StatefulWidget {
  const AuthenticatePage({super.key});

  @override
  State<AuthenticatePage> createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(IsUserLoggedInEvent());
   
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppUserCubit, AppUserState>(
      listener: (context, state) {
        if (state is AppUserLoggedInState) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoute.homeScreen, (route) => false);
        } else if (state is AppUserLoggedOutState) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoute.signIn, (route) => false);
        } else{
           Navigator.pushNamedAndRemoveUntil(
              context, AppRoute.signIn, (route) => false);

        }
      },
      builder: (context, state) {
     
        if (state is AppUserInitialState) {
          return const Scaffold(
            body: Center(
              child: Text('Splash',style: TextStyle(fontSize: 25,color: AppPallete.gradient1),),
            ),
          );
        } 
   
        return const Scaffold(
          body: SizedBox()
        );
      },
    );
  }
}






class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    check();
  }

  check() async {
    var prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');
    Timer(const Duration(milliseconds: 1000), () {
      if (userId != null) {
        if (userId != '') {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoute.blogPage,
            (route) => false,
          );
        }
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoute.signIn,
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Splash',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppPallete.gradient2,
                  fontSize: 25),
            ),
            ElevatedButton(
                onPressed: () async {
                  var auth = FirebaseAuth.instance;
                  auth.signOut().then((value) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoute.signIn,
                      (route) => false,
                    );
                  });
                },
                child: const Text('Sign In')),
          ],
        ),
      ),
    );
  }
}
