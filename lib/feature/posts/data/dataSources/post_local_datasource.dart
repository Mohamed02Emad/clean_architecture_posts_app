import 'package:dartz/dartz.dart';
import 'package:untitled/feature/posts/data/models/post_model.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> posts);
}

class PostLocalDataSourceImpl extends PostLocalDataSource{
  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    throw UnimplementedError();
  }

}