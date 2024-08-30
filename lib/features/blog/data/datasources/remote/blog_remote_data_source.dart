
import 'dart:io';

import 'package:clean_architecture_tdd/features/blog/data/models/blog_model.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog({required BlogModel blogModel});
  Future<String> uploadBlogImage(
      {required BlogModel blogModel, required File file});
  Future<List<BlogModel>> getAllBlog();
}
