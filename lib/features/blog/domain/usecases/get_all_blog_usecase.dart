import 'package:clean_architecture_tdd/core/error/failure.dart';
import 'package:clean_architecture_tdd/core/usecase/usecase.dart';
import 'package:clean_architecture_tdd/features/blog/domain/entities/blog.dart';
import 'package:clean_architecture_tdd/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogUseCase implements UseCase<List<BlogEntitie>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogUseCase(this.blogRepository);
  @override
  Future<Either<Failure, List<BlogEntitie>>> call(NoParams params) async{
    return await blogRepository.getAllBlogs();
  }
}
