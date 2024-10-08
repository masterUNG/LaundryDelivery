import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NewsModel {
  final String id;
  final String post;
  final String timePost;
  NewsModel({
    required this.id,
    required this.post,
    required this.timePost,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'post': post,
      'timePost': timePost,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      id: (map['id'] ?? '') as String,
      post: (map['post'] ?? '') as String,
      timePost: (map['timePost'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) => NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
