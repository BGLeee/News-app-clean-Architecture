import 'package:news_app_clean_architecture/features/domain/entities/article_entity.dart';
import 'package:news_app_clean_architecture/features/domain/repository/news_repository.dart';

class GetSavedArticleUseCase {
  final NewsRepository newsRepository;
  GetSavedArticleUseCase({required this.newsRepository});

  Future<List<ArticleEntity>> call() {
    return newsRepository.getSavedArticles();
  }
}
