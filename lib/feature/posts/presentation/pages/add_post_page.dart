import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/feature/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:untitled/feature/posts/presentation/widgets/addUpdatePage/form_widget.dart';
import 'package:untitled/injection_container.dart' as di;
import 'package:untitled/utils/navigation_util.dart';

import '../../domain/entities/post.dart';

class AddOrUpdatePostPage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const AddOrUpdatePostPage({required this.isUpdatePost, required this.post, super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
            isUpdatePost ? const Text("Update Post") : const Text("Add Post"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<PostsBloc, PostsState>(
            listener: (ctx, state) {
              if (state is AddDeleteUpdatePostStateSuccess) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));

                di.sl<AppNavigator>().pop();

                BlocProvider.of<PostsBloc>(context).add(GetAllPostsEvent());
              } else if (state is ErrorPostsState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (ctx, state) {

              if (state is LoadingPostsState) {

                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ));
              } else {
                return FormWidget(isUpdatePost: isUpdatePost , post: post,);
              }
            },
          ),
        ),
      ),
    );
  }
}
