import 'package:flutter/material.dart';
import 'package:untitled/feature/posts/presentation/widgets/postsPage/post_widget.dart';

import '../../../domain/entities/post.dart';

class PostsListWidget extends StatelessWidget {
  final List<Post> posts;

  const PostsListWidget({required this.posts, super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
            itemCount: posts.length,
            itemBuilder: (_, index) => PostWidget(post: posts[index]));
  }
}
