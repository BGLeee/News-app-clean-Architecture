import 'package:news_app_clean_architecture/features/domain/entities/article_entity.dart';
import 'package:news_app_clean_architecture/features/domain/repository/news_repository.dart';

class RemoveArticleUseCase {
  final NewsRepository newsRepository;
  RemoveArticleUseCase({required this.newsRepository});

  Future<void> call(ArticleEntity article) {
    return newsRepository.removeArticles(article);
  }
}
