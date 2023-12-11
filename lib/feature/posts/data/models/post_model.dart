import 'dart:convert';

import 'package:untitled/feature/posts/domain/entities/post.dart';


Post postFromJson(String str) => PostModel.fromJson(json.decode(str));

String postToJson(PostModel data) => json.encode(data.toJson());

class PostModel extends Post{
  const PostModel({required super.userId, required super.id, required super.title, required super.body});

  Post copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) =>
      Post(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
      );

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}