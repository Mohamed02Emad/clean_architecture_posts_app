import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/feature/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:untitled/feature/posts/presentation/pages/add_post_page.dart';
import 'package:untitled/feature/posts/presentation/widgets/postsPage/post_list_widget.dart';
import 'package:untitled/injection_container.dart' as di;

import '../../../../utils/navigation_util.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          title: const Text("Posts"),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          _navigateToAddPost();
        }, child: const Icon(Icons.add),),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state is LoadedPostsState) {
                return RefreshIndicator(onRefresh: () {
                 return _onRefresh(context);
                },
                child: PostsListWidget(posts: state.posts));
              } else if (state is ErrorPostsState) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is AddDeleteUpdatePostStateSuccess) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ),
                );
              }
            },
          ),
        ));
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());

  }

  void _navigateToAddPost() {
    di.sl<AppNavigator>().push(screen: const AddOrUpdatePostPage(post: null,isUpdatePost: false));

  }
}
