import 'package:flutter/material.dart';
import 'package:untitled/feature/posts/presentation/pages/add_post_page.dart';
import 'package:untitled/injection_container.dart' as di ;
import 'package:untitled/utils/navigation_util.dart';
import '../../../domain/entities/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1 , color: Colors.blue)
      ),
      child: InkWell(
        onTap: (){
          _navigateToUpdate(post);
        },
        child: Expanded(
          child: Row(
            children: [
              const SizedBox(
                width: 4,
              ),
              Text(post.id.toString()),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        // color: Colors.blueAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      post.body,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 10),
                    // const Divider(thickness: 2 , color: Colors.blue,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToUpdate(Post post) {

    di.sl<AppNavigator>().push(screen: AddOrUpdatePostPage(isUpdatePost: true , post: post,));
  }
}
