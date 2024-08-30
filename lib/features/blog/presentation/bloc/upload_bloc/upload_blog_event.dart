part of 'upload_blog_bloc.dart';

sealed class UploadBlogEvent extends Equatable {
  const UploadBlogEvent();

  @override
  List<Object> get props => [];
}

class BlogUploadEvent extends UploadBlogEvent {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;
  const BlogUploadEvent({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}