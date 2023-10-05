part of 'local_article_cubit.dart';

sealed class LocalArticleState extends Equatable {
  const LocalArticleState();

  @override
  List<Object> get props => [];
}

final class LocalArticleInitial extends LocalArticleState {
  @override
  List<Object> get props => [];
}

final class LocalArticleLoading extends LocalArticleState {
  @override
  List<Object> get props => [];
}

final class LocalArticleLoaded extends LocalArticleState {
  final List<ArticleEntity> news;
  LocalArticleLoaded(this.news);
  @override
  List<Object> get props => [news];
}

final class LocalArticleFailure extends LocalArticleState {
  @override
  List<Object> get props => [];
}
