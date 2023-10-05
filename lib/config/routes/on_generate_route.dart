import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/const.dart';
import 'package:news_app_clean_architecture/features/domain/entities/article_entity.dart';
import 'package:news_app_clean_architecture/features/presentation/pages/detail_article_page.dart';
import 'package:news_app_clean_architecture/features/presentation/pages/main_page.dart';
import 'package:news_app_clean_architecture/features/presentation/pages/saved_articles/saved_aricles_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case PageConst.mainPage:
        {
          return routeBuilder(const MainPage());
        }
      case PageConst.savedArticlePage:
        {
          return routeBuilder(const SavedArticles());
        }

      case PageConst.detailArticlePage:
        {
          if (args is ArticleEntity) {
            return routeBuilder(DetailArticlePage(article: args));
          } else {
            return routeBuilder(const MainPage());
          }
        }
      default:
        {
          const NoPageFound();
        }
    }
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page not found"),
      ),
      body: const Center(
        child: Text("Page not found"),
      ),
    );
  }
}
