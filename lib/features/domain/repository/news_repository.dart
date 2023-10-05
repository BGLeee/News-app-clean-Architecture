import 'package:news_app_clean_architecture/features/domain/entities/article_entity.dart';

abstract class NewsRepository {
  Future<List<ArticleEntity>> getNews();

  Future<List<ArticleEntity>> getSavedArticles();
  Future<void> saveArticles(ArticleEntity article);
  Future<void> removeArticles(ArticleEntity article);
}
