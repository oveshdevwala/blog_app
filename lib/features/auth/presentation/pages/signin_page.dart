import 'package:clean_architecture_tdd/core/app_routes/app_routes.dart';
import 'package:clean_architecture_tdd/core/theme/app_pallete.dart';
import 'package:clean_architecture_tdd/core/utiles/show_snackbar.dart';
import 'package:clean_architecture_tdd/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:clean_architecture_tdd/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/auth_gradient_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailContoller = TextEditingController();
  final passwordContoller = TextEditingController();
  final formKeySign = GlobalKey<FormState>();

  @override
  void dispose() {
    emailContoller.dispose();
    passwordContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKeySign,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Sign In.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: AppPallete.whiteColor)),
                  const SizedBox(height: 20),
                  AuthField(hintText: 'Email', controller: emailContoller),
                  const SizedBox(height: 12),
                  AuthField(
                    hintText: 'Password',
                    isobscureText: true,
                    controller: passwordContoller,
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoadedState) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoute.homeScreen,
                          (route) => false,
                        );
                      }
                      if (state is AuthFailureState) {
                        showSnackBar(context, state.errorMsg);
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return AuthGradientButton(
                          onTap: () {},
                          btName: '',
                          widget: const CircularProgressIndicator(
                            color: AppPallete.whiteColor,
                          ),
                        );
                      }
                      else if (state is AuthFailureState) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AuthGradientButton(
                              onTap: () {
                                if (formKeySign.currentState!.validate()) {
                                  context.read<AuthBloc>().add(AuthSignInEvent(
                                      email: emailContoller.text.toString(),
                                      password:
                                          passwordContoller.text.toString()));
                                }
                              },
                              btName: 'Retry',
                            ),
                            Text(
                              state.errorMsg,
                              style: const TextStyle(
                                  color: AppPallete.gradient1,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        );
                      }
                      return AuthGradientButton(
                        btName: 'Sign In',
                        onTap: () {
                          if (formKeySign.currentState!.validate()) {
                            context.read<AuthBloc>().add(AuthSignInEvent(
                                email: emailContoller.text.toString(),
                                password: passwordContoller.text.toString()));
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoute.signUp);
                    },
                    child: RichText(
                        text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: AppPallete.gradient2,
                                    fontWeight: FontWeight.bold)),
                      ],
                    )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
