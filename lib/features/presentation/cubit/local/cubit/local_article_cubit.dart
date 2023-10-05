import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_clean_architecture/features/domain/entities/article_entity.dart';
import 'package:news_app_clean_architecture/features/domain/usecases/get_saved_article_usecase.dart';
import 'package:news_app_clean_architecture/features/domain/usecases/remote_article_usecase.dart';
import 'package:news_app_clean_architecture/features/domain/usecases/save_article_usecase.dart';

part 'local_article_state.dart';

class LocalArticleCubit extends Cubit<LocalArticleState> {
  final GetSavedArticleUseCase getSavedArticleUseCase;
  final RemoveArticleUseCase removeArticleUseCase;
  final SaveArticleUseCase saveArticleUseCase;
  LocalArticleCubit(
      {required this.getSavedArticleUseCase,
      required this.removeArticleUseCase,
      required this.saveArticleUseCase})
      : super(LocalArticleInitial());

  Future<void> saveArticles(ArticleEntity article) async {
    emit(LocalArticleLoading());
    try {
      final articles = await saveArticleUseCase.call(article);
    } on SocketException catch (e) {
      emit(LocalArticleFailure());
    } catch (_) {
      emit(LocalArticleFailure());
    }
  }

  Future<void> getArticles(ArticleEntity article) async {
    log("Are wiiiiiii");
    emit(LocalArticleLoading());
    try {
      final articles = await getSavedArticleUseCase.call();
      emit(LocalArticleLoaded(articles));
    } on SocketException catch (e) {
      print(e);
      emit(LocalArticleFailure());
    } catch (_) {
      print(_);

      emit(LocalArticleFailure());
    }
  }

  Future<void> removeArticles(ArticleEntity article) async {
    emit(LocalArticleLoading());
    try {
      final articles = await removeArticleUseCase.call(article);
    } on SocketException catch (e) {
      emit(LocalArticleFailure());
    } catch (_) {
      emit(LocalArticleFailure());
    }
  }
}
