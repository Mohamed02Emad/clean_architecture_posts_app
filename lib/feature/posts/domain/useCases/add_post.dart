import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class AddPostUseCase {
  final PostsRepository postsRepository;

  AddPostUseCase({required this.postsRepository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return await postsRepository.addPost(post);
  }
}
