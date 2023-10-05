part of 'news_cubit.dart';

sealed class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

final class NewsInitial extends NewsState {
  @override
  List<Object> get props => [];
}

final class NewsLoading extends NewsState {
  @override
  List<Object> get props => [];
}

final class NewsLoaded extends NewsState {
  final List<ArticleEntity> news;
  const NewsLoaded(this.news);
  @override
  List<Object> get props => [news];
}

final class NewsFailure extends NewsState {
  @override
  List<Object> get props => [];
}
