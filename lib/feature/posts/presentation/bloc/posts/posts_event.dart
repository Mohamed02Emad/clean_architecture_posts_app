part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class GetAllPostsEvent extends PostsEvent {}
class RefreshPostsEvent extends PostsEvent {}

class AddPostEvent extends PostsEvent {
  final Post post;
  AddPostEvent({required this.post });
  @override
  List<Object?> get props => [post];
}
class DeletePostEvent extends PostsEvent {
  final int postId;
  DeletePostEvent({required this.postId});
}
class UpdatePostEvent extends PostsEvent {
  final Post post;
  UpdatePostEvent({required this.post });
  @override
  List<Object?> get props => [post];
}



