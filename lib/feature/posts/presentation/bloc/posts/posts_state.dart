part of 'posts_bloc.dart';

@immutable
abstract class PostsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostsInitialState extends PostsState {}

class LoadingPostsState extends PostsState {}

class ErrorPostsState extends PostsState {
  final String message;

  ErrorPostsState({required this.message});
}

class LoadedPostsState extends PostsState {
  final List<Post> posts;

  LoadedPostsState({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class AddDeleteUpdatePostStateSuccess extends PostsState {
  final String message;
  AddDeleteUpdatePostStateSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

