// ignore_for_file: body_might_complete_normally_nullable, unused_local_variable

import 'dart:io';

import 'package:clean_architecture_tdd/core/const/firebase_const.dart';
import 'package:clean_architecture_tdd/core/error/exception.dart';
import 'package:clean_architecture_tdd/features/auth/data/models/user_model.dart';
import 'package:clean_architecture_tdd/features/blog/data/datasources/remote/blog_remote_data_source.dart';
import 'package:clean_architecture_tdd/features/blog/data/models/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final Reference firebaseStorage;
  final FirebaseFirestore firebaseFirestore;

  BlogRemoteDataSourceImpl(this.firebaseStorage, this.firebaseFirestore);
  @override
  Future<BlogModel> uploadBlog({required BlogModel blogModel}) async {
    try {
      await firebaseFirestore
          .collection(FirebaseCollectionConst.blog)
          .doc()
          .set(blogModel.toMap());

      return blogModel;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required BlogModel blogModel, required File file}) async {
    try {
      var blogBucket = firebaseStorage
          .child('blog')
          .child('thumbnail')
          .child('${blogModel.id}.jpg');
      await blogBucket.putFile(file);
      return await blogBucket.getDownloadURL();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlog() async {
    List<BlogModel> blogList = [];
    if(blogList.isEmpty){

    var snap = await firebaseFirestore
        .collection(
            FirebaseCollectionConst.blog) // Adjust collection name as needed
        .get(); // Creates a stream
    // snap.docs.map((snaps) async {
    for (var doc in snap.docs) {
      var blogModel = BlogModel.fromMap(doc.data());
      var userDoc = await firebaseFirestore
          .collection(
              FirebaseCollectionConst.user) // Adjust collection name as needed
          .doc(blogModel.posterId)
          .get();

      var userModel = UserModel.fromJson(userDoc.data()!);
      blogList.add(
        blogModel.copyWith(posterName: userModel.name),
      );
    }
    
    }
    return blogList;
    // }); // Use asyncMap to handle async operations within a stream
    // return blogList;
  }
}
