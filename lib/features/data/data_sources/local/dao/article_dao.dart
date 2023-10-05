import 'package:floor/floor.dart';
import 'package:news_app_clean_architecture/features/data/model/article_model.dart';

abstract class ArticleDao {
  @Insert()
  Future<void> insertArticle(ArticleModel article);

  @delete
  Future<void> deleteArticle(ArticleModel article);

  @Query('SELECT * FROM article')
  Future<List<ArticleModel>> getArticle();
}
