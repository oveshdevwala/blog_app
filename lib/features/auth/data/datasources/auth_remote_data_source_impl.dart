import 'package:clean_architecture_tdd/core/const/shared_prefrences_const/shared_prefrences_const.dart';
import 'package:clean_architecture_tdd/core/error/exception.dart';
import 'package:clean_architecture_tdd/core/const/firebase_const.dart';
import 'package:clean_architecture_tdd/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architecture_tdd/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth fireAuth;
  final FirebaseFirestore firestore;
  AuthRemoteDataSourceImpl(this.fireAuth, this.firestore);

// Sign in User
  @override
  Future<UserModel> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final credential = await fireAuth.signInWithEmailAndPassword(
          email: email, password: password);

      var uId = credential.user!.uid;
      storeUserId(uId);
      UserModel? updateUserData =
          UserModel(uId: uId, email: credential.user!.email!, name: 'Null');
      if (credential.user == null) {
        throw const ServerException('User is null');
      }
      return UserModel.fromJson(updateUserData.toMap());
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        throw ("user not found");
      } else if (e.code == "wrong-password") {
        throw ("Invalid email or password");
      } else {
        throw ' Email or password is wrong';
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } 
  }

// Store UserId into SharedPreferences Database
  storeUserId(String userId) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(PrefsConst.userId, userId);
  }

// Sign Up User
  @override
  Future<UserModel> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      var credential = await fireAuth.createUserWithEmailAndPassword(
        password: password,
        email: email,
      );
      var uId = credential.user!.uid;
      storeUserId(uId);
      UserModel? updateUserData =
          UserModel(uId: uId, email: credential.user!.email!, name: name);
      if (credential.user == null) {
        throw const ServerException('User is null!');
      }
      if (credential.additionalUserInfo!.isNewUser) {
        await firestore
            .collection(FirebaseCollectionConst.user)
            .doc(uId)
            .set(updateUserData.toMap());
      }
      return UserModel.fromJson(updateUserData.toMap());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else if (e.code == 'operation-not-allowed') {
        throw Exception('There is a problem with auth service config :/');
      } else if (e.code == 'weak-password') {
        throw Exception('Please type stronger password');
      } else {
        throw ("$e");
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

// Get current User UId
  @override
  User? get currentUserId => fireAuth.currentUser;
  // User? get currentUserId => fireAuth.currentUser;
// Get User Data by Uid
  Future<String?> getCurrentUserId() async {
    var pref = await SharedPreferences.getInstance();
    String? userId = pref.getString(PrefsConst.userId);
    return userId;
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      print('collecting user Data');
      print('SharedPreferences Called');
      String? userId = await getCurrentUserId();
      if (userId == null) {
        print('Null Called');
        return null;
      }
      if (userId.isNotEmpty) {
        print('Collected user Data is NotEmpty');
        // print('Collected user Data empty');
        final userData = await firestore
            .collection(FirebaseCollectionConst.user)
            .doc(userId)
            .get();
        return UserModel.fromJson(userData.data()!);
      }

      return null;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
}
