import 'package:news_app_clean_architecture/features/data/data_sources/remote_data_source.dart';
import 'package:news_app_clean_architecture/features/domain/entities/article_entity.dart';
import 'package:news_app_clean_architecture/features/domain/repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource newsRemoteDataSource;
  NewsRepositoryImpl({required this.newsRemoteDataSource});
  @override
  Future<List<ArticleEntity>> getNews() {
    return newsRemoteDataSource.getNews();
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() {
    return newsRemoteDataSource.getSavedArticles();
  }

  @override
  Future<void> removeArticles(ArticleEntity article) {
    return newsRemoteDataSource.removeArticles(article);
  }

  @override
  Future<void> saveArticles(ArticleEntity article) {
    return newsRemoteDataSource.saveArticles(article);
  }
}
