// import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:clean_architecture_tdd/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword(
      {required String name, required String email, required String password});
  Future<UserModel> signInWithEmailPassword(
      {required String email, required String password});
  User? get currentUserId;
  Future<UserModel?> getCurrentUserData();
}


// Manage Sessions With Firebase
// with Firebase authStateChanges()Listener(User? user)
// if(user != null && mounted){
// True => Home
// false => Login
// }
