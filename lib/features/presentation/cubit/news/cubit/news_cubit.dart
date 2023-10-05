import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_clean_architecture/features/domain/entities/article_entity.dart';
import 'package:news_app_clean_architecture/features/domain/usecases/news/get_news_usecase.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final GetNewsUseCase getNewsUseCase;
  NewsCubit({required this.getNewsUseCase}) : super(NewsInitial());

  Future<void> getNews(ArticleEntity article) async {
    print("its loadingdfsdfsf state");
    emit(NewsLoading());
    try {
      final news = await getNewsUseCase.call();
      emit(NewsLoaded(news));
    } catch (e) {
      emit(NewsFailure());
    }
  }
}
