import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/app_theme.dart';
import 'package:untitled/feature/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:untitled/feature/posts/presentation/pages/posts_page.dart';

import 'injection_container.dart' as di;
import 'utils/navigation_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostsBloc>(
          create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent()),
        ),
      ],
      child: MaterialApp(
        theme: appTheme,
        navigatorKey: di.sl<AppNavigator>().navigatorKey,
        home: const PostsPage(),
      ),
    );
  }
}
