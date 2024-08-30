// ignore_for_file: public_member_api_docs, sort_constructors_first

class BlogEntitie {
  final String id;
  final String posterId;
  final String? posterName;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final String uploadAt;

  BlogEntitie(
      {required this.id,
      required this.posterId,
      this.posterName,
      required this.title,
      required this.content,
      required this.imageUrl,
      required this.topics,
      required this.uploadAt});
}
