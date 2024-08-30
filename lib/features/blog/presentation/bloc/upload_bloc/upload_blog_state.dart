part of 'upload_blog_bloc.dart';

sealed class UploadBlogState extends Equatable {
  const UploadBlogState();
  
  @override
  List<Object> get props => [];
}

final class UploadBlogInitial extends UploadBlogState {}

class UploadBlogLoadingState extends UploadBlogState {}

class UploadBlogSuccesState extends UploadBlogState {}
class UploadBlogFailureState extends UploadBlogState {
  final String error;
  const UploadBlogFailureState({
    required this.error,
  });
}
