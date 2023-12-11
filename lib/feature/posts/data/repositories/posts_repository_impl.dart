import 'package:dartz/dartz.dart';
import 'package:untitled/core/error/exception.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/core/network/network.dart';
import 'package:untitled/feature/posts/data/models/post_model.dart';
import 'package:untitled/feature/posts/domain/entities/post.dart';
import 'package:untitled/feature/posts/domain/repositories/posts_repository.dart';

import '../dataSources/post_local_datasource.dart';
import '../dataSources/post_remote_datasource.dart';

class PostsRepositoryImpl extends PostsRepository {
  final PostRemoteDataSource postRemoteDataSource;
  final PostLocalDataSource postLocalDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl({
    required this.postRemoteDataSource,
    required this.postLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final postModel = PostModel(
        userId: post.userId, id: post.id, title: post.title, body: post.body);
    return _getMessage(() => postRemoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return _getMessage(() => postRemoteDataSource.deletePost(id));
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    final isDeviceConnected = await networkInfo.isConnected();
    if (isDeviceConnected) {
      try {
        final allPosts = await postRemoteDataSource.getAllPosts();
      //  postLocalDataSource.cachePosts(allPosts);
        return Right(allPosts);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final allPosts = await postLocalDataSource.getCachedPosts();
        return Right(allPosts);
      } catch (error) {
        return Left(EmptyCasheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final postModel = PostModel(
        userId: post.userId, id: post.id, title: post.title, body: post.body);
    return _getMessage(() => postRemoteDataSource.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> _getMessage(
      Future<Unit> Function() deleteUpdateOrAddPost) async {
    final isDeviceConnected = await networkInfo.isConnected();
    if (isDeviceConnected) {
      try {
        await deleteUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
