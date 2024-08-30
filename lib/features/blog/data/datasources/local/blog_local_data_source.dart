import 'package:clean_architecture_tdd/features/blog/data/models/blog_model.dart';

abstract interface class BlogLocalDataSource {
  List<BlogModel> loadBlogs();
  void uploadLocalBlogs({required List<BlogModel> blogs});
}
