import 'package:dartz/dartz.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/posts/domain/repositories/posts_repository.dart';

import '../entities/post.dart';

class UpdatePostUseCase {
  final PostsRepository postsRepository;

  UpdatePostUseCase({required this.postsRepository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return await postsRepository.updatePost(post);
  }
}
