import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/injection_container.dart' as di;
import '../../../domain/entities/post.dart';
import '../../bloc/posts/posts_bloc.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({required this.isUpdatePost, this.post, super.key});

  final Post? post;
  final bool isUpdatePost;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdatePost) {
      print("Mohamed is going to update ${widget.post.toString()}");

      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Mohamed is going to update ${widget.post.toString()}");
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: _titleController,
                validator: (val) => val!.isEmpty ? "cannot be empty" : null,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                    hintText: "title"),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: _bodyController,
                validator: (val) => val!.isEmpty ? "cannot be empty" : null,
                minLines: 6,
                maxLines: 8,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                    hintText: "body"),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton.icon(
              icon: widget.isUpdatePost
                  ? const Icon(Icons.edit)
                  : const Icon(Icons.add),
              onPressed: () {validateFormThenUpdateOrAdd();},
              label: Text(widget.isUpdatePost ? "Update" : "Add"),
            )
          ],
        ));
  }

  void validateFormThenUpdateOrAdd() {
    final isValidForm = _formKey.currentState!.validate();

    if (isValidForm) {
      final post = Post(
          userId: widget.post?.userId ?? 1,
          id: widget.isUpdatePost ? widget.post!.id : null,
          title: _titleController.text,
          body: _bodyController.text);

      if (widget.isUpdatePost) {
        BlocProvider.of<PostsBloc>(context).add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<PostsBloc>(context).add(AddPostEvent(post: post));
      }
    }
  }
}
