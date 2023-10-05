import 'package:get_it/get_it.dart';
import 'package:news_app_clean_architecture/features/data/data_sources/local/app_database.dart';
import 'package:news_app_clean_architecture/features/data/data_sources/remote_data_source.dart';
import 'package:news_app_clean_architecture/features/data/data_sources/remote_data_source_impl.dart';
import 'package:news_app_clean_architecture/features/data/repository/news_repository_impl.dart';
import 'package:news_app_clean_architecture/features/domain/repository/news_repository.dart';
import 'package:news_app_clean_architecture/features/domain/usecases/get_saved_article_usecase.dart';
import 'package:news_app_clean_architecture/features/domain/usecases/news/get_news_usecase.dart';
import 'package:news_app_clean_architecture/features/domain/usecases/remote_article_usecase.dart';
import 'package:news_app_clean_architecture/features/domain/usecases/save_article_usecase.dart';
import 'package:news_app_clean_architecture/features/presentation/cubit/local/cubit/local_article_cubit.dart';
import 'package:news_app_clean_architecture/features/presentation/cubit/news/cubit/news_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);
  sl.registerFactory(() => NewsCubit(getNewsUseCase: sl.call()));
  sl.registerFactory(() => LocalArticleCubit(
      getSavedArticleUseCase: sl.call(),
      saveArticleUseCase: sl.call(),
      removeArticleUseCase: sl.call()));

  sl.registerLazySingleton(() => GetNewsUseCase(newsRepository: sl.call()));
  sl.registerLazySingleton(
      () => GetSavedArticleUseCase(newsRepository: sl.call()));
  sl.registerLazySingleton(
      () => RemoveArticleUseCase(newsRepository: sl.call()));
  sl.registerLazySingleton(() => SaveArticleUseCase(newsRepository: sl.call()));

  sl.registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(newsRemoteDataSource: sl.call()));
  sl.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(sl.call()));
}
