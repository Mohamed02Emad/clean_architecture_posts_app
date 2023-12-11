import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:untitled/core/error/failure.dart';
import 'package:untitled/feature/posts/domain/useCases/add_post.dart';
import 'package:untitled/feature/posts/domain/useCases/delete_post.dart';
import 'package:untitled/feature/posts/domain/useCases/update_post.dart';

import '../../../domain/entities/post.dart';
import '../../../domain/useCases/get_all_posts.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;
  final UpdatePostUseCase updatePost;
  final DeletePostUseCase deletePost;
  final AddPostUseCase addPost;

  PostsBloc({
    required this.getAllPosts,
    required this.addPost,
    required this.deletePost,
    required this.updatePost,
  }) : super(PostsInitialState()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final posts = await getAllPosts();

        posts.fold((failure) {
          emit(ErrorPostsState(message: getFailureMessage(failure)));
        }, (posts) {
          emit(LoadedPostsState(posts: posts));
        });
      } else if (event is AddPostEvent) {
        _handleAddDeleteUpdatePostRequest("Post added" ,() => addPost(event.post));
      } else if (event is DeletePostEvent) {
        _handleAddDeleteUpdatePostRequest("Post deleted",() => deletePost(event.postId));
      } else if (event is UpdatePostEvent) {
        _handleAddDeleteUpdatePostRequest("Post Updated",() => updatePost(event.post));
      }
    });
  }

  void _handleAddDeleteUpdatePostRequest(
      String message ,
      Future<Either<Failure, Unit>> Function() addDeleteUpdatePostFunc) async {
    emit(LoadingPostsState());
    final updatePostRequest = await addDeleteUpdatePostFunc();
    updatePostRequest.fold((failure) {
      emit(ErrorPostsState(message: getFailureMessage(failure)));
    }, (_) {
      emit(AddDeleteUpdatePostStateSuccess(message: message));
    });
  }
}
