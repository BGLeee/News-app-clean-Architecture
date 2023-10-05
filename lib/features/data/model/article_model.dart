import 'dart:math';

import 'package:floor/floor.dart';
import 'package:news_app_clean_architecture/features/domain/entities/article_entity.dart';

@Entity(tableName: 'article', primaryKeys: [''])
class ArticleModel extends ArticleEntity {
  final String? author;
  final String? id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? content;
  final String? articleUrl;
  final String? publishedAt;

  const ArticleModel(
      {this.publishedAt,
      this.id,
      this.author,
      this.title,
      this.description,
      this.articleUrl,
      this.content,
      this.imageUrl})
      : super(
          author: author,
          publishedAt: publishedAt,
          articleUrl: articleUrl,
          title: title,
          description: description,
          imageUrl: imageUrl,
          content: content,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
        id: Random().nextInt(10000).toString(),
        author: json['author'],
        title: json['title'],
        description: json['description'],
        imageUrl: json['urlToImage'],
        content: json['content'],
        publishedAt: json['publishedAt'],
        articleUrl: json['url']);
  }
  factory ArticleModel.fromEntity(ArticleEntity entity) {
    return ArticleModel(
        id: entity.id,
        author: entity.author,
        title: entity.title,
        description: entity.description,
        articleUrl: entity.articleUrl,
        imageUrl: entity.imageUrl,
        publishedAt: entity.publishedAt,
        content: entity.content);
  }
}
