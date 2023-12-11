import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/core/error/exception.dart';
import 'package:untitled/feature/posts/data/models/post_model.dart';
import 'package:untitled/utils/constants.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int postId);

  Future<Unit> updatePost(PostModel post);

  Future<Unit> addPost(PostModel post);
}

class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> addPost(PostModel post) async {
    try {
      final jsonPost = jsonEncode(post.toJson());
      final response = await client.post(Uri.parse("$BASE_URL$POSTS_ENDPOINT"),
          body: jsonPost);

      if (response.statusCode == 201) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
        Uri.parse("$BASE_URL$POSTS_ENDPOINT/${postId.toString()}"),
        headers: {'content-type': 'application/json'});

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse("$BASE_URL$POSTS_ENDPOINT"),
      headers: {'content-type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> posts =
          decodedJson.map<PostModel>((e) => PostModel.fromJson(e)).toList();

      return posts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    final jsonPost = jsonEncode(post.toJson());
    final response = await client.patch(
        Uri.parse("$BASE_URL$POSTS_ENDPOINT/${post.id.toString()}"),
        body: jsonPost);

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
