// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'blog_bloc.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

class BlogInitialState extends BlogState {}


class BlogSuccesState extends BlogState {
  final List<BlogEntitie> blog;

 const BlogSuccesState(this.blog);
}

class BlogLoadingState extends BlogState {}
class BlogFailureState extends BlogState {
  final String error;
  const BlogFailureState({
    required this.error,
  });
}
