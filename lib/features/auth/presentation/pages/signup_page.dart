import 'package:clean_architecture_tdd/core/app_routes/app_routes.dart';
import 'package:clean_architecture_tdd/core/theme/app_pallete.dart';
import 'package:clean_architecture_tdd/core/utiles/show_snackbar.dart';
import 'package:clean_architecture_tdd/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:clean_architecture_tdd/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/auth_gradient_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailContoller = TextEditingController();
  final nameContoller = TextEditingController();
  final passwordContoller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailContoller.dispose();
    nameContoller.dispose();
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
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Sign Up.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: AppPallete.whiteColor)),
                  const SizedBox(height: 20),
                  AuthField(hintText: 'Name', controller: nameContoller),
                  const SizedBox(height: 12),
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
                            ));
                      }
                      if (state is AuthFailureState) {
                        return AuthGradientButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(AuthSignUpEvent(
                                  name: nameContoller.text.toString().trim(),
                                  email: emailContoller.text.toString().trim(),
                                  password: passwordContoller.text
                                      .toString()
                                      .trim()));
                            }
                          },
                          btName: 'Sign Up',
                        );
                      }

                      return AuthGradientButton(
                        btName: 'Sign Up',
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(AuthSignUpEvent(
                                name: nameContoller.text.toString().trim(),
                                email: emailContoller.text.toString().trim(),
                                password:
                                    passwordContoller.text.toString().trim()));
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: RichText(
                        text: TextSpan(
                      text: 'Already have an account? ',
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                            text: 'Sign In',
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
