import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/core/network/network.dart';
import 'package:untitled/feature/posts/data/dataSources/post_local_datasource.dart';
import 'package:untitled/feature/posts/data/dataSources/post_remote_datasource.dart';
import 'package:untitled/feature/posts/data/repositories/posts_repository_impl.dart';
import 'package:untitled/feature/posts/domain/repositories/posts_repository.dart';
import 'package:untitled/feature/posts/domain/useCases/add_post.dart';
import 'package:untitled/feature/posts/domain/useCases/delete_post.dart';
import 'package:untitled/feature/posts/domain/useCases/get_all_posts.dart';
import 'package:untitled/feature/posts/domain/useCases/update_post.dart';
import 'package:untitled/feature/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:untitled/utils/navigation_util.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /**
      feature posts
   **/

  //Bloc
  sl.registerFactory(
    () => PostsBloc(
      getAllPosts: sl(),
      addPost: sl(),
      deletePost: sl(),
      updatePost: sl(),
    ),
  );

  //use cases
  sl.registerLazySingleton(() => GetAllPostsUseCase(postsRepository: sl()));
  sl.registerLazySingleton(() => AddPostUseCase(postsRepository: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(postsRepository: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(postsRepository: sl()));

  //repositories
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
        postRemoteDataSource: sl(),
        postLocalDataSource: sl(),
        networkInfo: sl(),
      ));

  //data sources
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl());

  /**
      core
   **/
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  /**
      external
   **/

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => AppNavigator());
}
