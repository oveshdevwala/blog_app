import 'package:clean_architecture_tdd/features/auth/presentation/pages/signin_page.dart';
import 'package:clean_architecture_tdd/features/auth/presentation/pages/signup_page.dart';
import 'package:clean_architecture_tdd/features/auth/presentation/pages/auth_checker.dart';
import 'package:clean_architecture_tdd/features/blog/presentation/pages/add_blog.dart';
import 'package:clean_architecture_tdd/features/blog/presentation/pages/blog_page.dart';
import 'package:clean_architecture_tdd/features/blog/presentation/pages/read_blog_page.dart';
import 'package:clean_architecture_tdd/home_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const String isLogged = '/';
  static const String signUp = '/signUp';
  static const String signIn = '/signIn';
  static const String homeScreen = '/home';
  static const String splashScreen = '/splash';
  static const String blogPage = '/blogPage';
  static const String addPostblog = '/addPostblog';
  static const String readBlogPage = '/ReadBlogPage';
  // static const String signUp = '/signUp';

  static Map<String, WidgetBuilder> get routes => {
        isLogged: (context) => const AuthenticatePage(),
        signUp: (context) => const SignUpPage(),
        signIn: (context) => const SignInPage(),
        homeScreen: (context) => const HomeScreen(),
        splashScreen: (context) => const SplashPage(),
        blogPage: (context) => const BlogPage(),
        addPostblog: (context) => const AddBlogPostPage(),
        readBlogPage: (context) => const ReadBlogPage(),
      };
}
