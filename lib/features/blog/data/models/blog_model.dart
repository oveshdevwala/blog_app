import 'package:clean_architecture_tdd/features/blog/domain/entities/blog.dart';

class BlogModel extends BlogEntitie {
  BlogModel(
      {required super.id,
      required super.posterId,
      required super.title,
      required super.content,
      required super.imageUrl,
      required super.topics,
      required super.uploadAt,
      super.posterName});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'posterId': posterId,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'topics': topics,
      'uploadAt': uploadAt,
      'posterName': posterName
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    List<String> listOfString = [];
    for (var eachString in map['topics']) {
      listOfString.add(eachString);
    }
    return BlogModel(
      id: map['id'] as String,
      posterId: map['posterId'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['imageUrl'] as String,
      topics: listOfString,
      uploadAt: map['uploadAt'] as String,
    );
  }

  BlogModel copyWith(
      {String? id,
      String? posterId,
      String? title,
      String? content,
      String? imageUrl,
      List<String>? topics,
      String? uploadAt,
      String? posterName}) {
    return BlogModel(
        id: id ?? this.id,
        posterId: posterId ?? this.posterId,
        title: title ?? this.title,
        content: content ?? this.content,
        imageUrl: imageUrl ?? this.imageUrl,
        topics: topics ?? this.topics,
        uploadAt: uploadAt ?? this.uploadAt,
        posterName: posterName ?? this.posterName);
  }
}
