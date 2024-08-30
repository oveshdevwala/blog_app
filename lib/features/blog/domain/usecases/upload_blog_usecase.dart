// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:clean_architecture_tdd/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

import 'package:clean_architecture_tdd/core/error/failure.dart';
import 'package:clean_architecture_tdd/core/usecase/usecase.dart';
import 'package:clean_architecture_tdd/features/blog/domain/repositories/blog_repository.dart';

class UploadBlogUseCase implements UseCase<BlogEntitie, UploadBlogParam> {
  final BlogRepository blogRepository;

  UploadBlogUseCase(this.blogRepository);
  @override
  Future<Either<Failure, BlogEntitie>> call(UploadBlogParam params) async {
    return await blogRepository.uploadBlog(
        posterId: params.posterId,
        title: params.title,
        content: params.content,
        image: params.image,
        topics: params.topics);
  }
}

class UploadBlogParam {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;
  UploadBlogParam({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}
