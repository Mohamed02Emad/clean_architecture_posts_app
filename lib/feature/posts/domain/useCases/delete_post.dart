import 'package:dartz/dartz.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/posts/domain/repositories/posts_repository.dart';

class DeletePostUseCase {
  final PostsRepository postsRepository;

  DeletePostUseCase({required this.postsRepository});

  Future<Either<Failure, Unit>> call(int postId) async {
    return await postsRepository.deletePost(postId);
  }
}
