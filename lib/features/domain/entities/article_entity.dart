import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final String? author;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? content;
  final String? publishedAt;
  final String? articleUrl;
  final String? id;

  const ArticleEntity(
      {this.publishedAt,
      this.author,
      this.id,
      this.title,
      this.description,
      this.content,
      this.articleUrl,
      this.imageUrl});

  @override
  List<Object?> get props => [
        author,
        id,
        title,
        description,
        content,
        imageUrl,
        articleUrl,
      ];
}
