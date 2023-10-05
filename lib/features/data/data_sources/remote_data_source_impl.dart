import 'dart:convert';
import 'package:http/http.dart';
import 'package:news_app_clean_architecture/features/data/data_sources/local/app_database.dart';
import 'package:news_app_clean_architecture/features/data/data_sources/remote_data_source.dart';
import 'package:news_app_clean_architecture/features/data/model/article_model.dart';
import 'package:news_app_clean_architecture/features/domain/entities/article_entity.dart';

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final AppDatabase _appDatabase;
  NewsRemoteDataSourceImpl(this._appDatabase);

  @override
  Future<List<ArticleModel>> getNews() async {
    String endPoint =
        "https://newsapi.org/v2/top-headlines?q=Premier League&apiKey=e1f4bf1b5e1e47738b70666ac0d315ab";
    Response response = await get(Uri.parse(endPoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['articles'];
      return result.map((e) => ArticleModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() {
    return _appDatabase.articleDAO.getArticle();
  }

  @override
  Future<void> removeArticles(ArticleEntity article) {
    return _appDatabase.articleDAO
        .deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticles(ArticleEntity article) {
    return _appDatabase.articleDAO
        .insertArticle(ArticleModel.fromEntity(article));
  }
}
