// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import 'package:clean_architecture_tdd/core/error/exception.dart';
import 'package:clean_architecture_tdd/core/error/failure.dart';
import 'package:clean_architecture_tdd/core/network/connection_checker.dart';
import 'package:clean_architecture_tdd/features/blog/data/datasources/local/blog_local_data_source.dart';
import 'package:clean_architecture_tdd/features/blog/data/datasources/remote/blog_remote_data_source.dart';
import 'package:clean_architecture_tdd/features/blog/data/models/blog_model.dart';
import 'package:clean_architecture_tdd/features/blog/domain/entities/blog.dart';
import 'package:clean_architecture_tdd/features/blog/domain/repositories/blog_repository.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;
  BlogRepositoryImpl(
    this.blogRemoteDataSource,
    this.blogLocalDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, BlogEntitie>> uploadBlog(
      {required String posterId,
      required String title,
      required String content,
      required File image,
      required List<String> topics}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure('No Internet connection'));
      }
      BlogModel blogModel = BlogModel(
          id: const Uuid().v1(),
          posterId: posterId,
          title: title,
          content: content,
          imageUrl: '',
          topics: topics,
          uploadAt: DateTime.now().millisecondsSinceEpoch.toString());
      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
          blogModel: blogModel, file: image);
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final uploadedBlog =
          await blogRemoteDataSource.uploadBlog(blogModel: blogModel);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntitie>>> getAllBlogs() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }
      final blogs = await blogRemoteDataSource.getAllBlog();
      blogLocalDataSource.uploadLocalBlogs(blogs: blogs);

      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
