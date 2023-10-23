import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/const.dart';
import 'package:news_app_clean_architecture/features/domain/entities/article_entity.dart';
import 'package:news_app_clean_architecture/features/presentation/cubit/news/cubit/news_cubit.dart';
import 'package:news_app_clean_architecture/features/presentation/widgets/article_card_widget.dart';
import 'package:news_app_clean_architecture/injection_container.dart' as ic;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void _refreshContent() async {
    // setState(() {
    //   impl.getNews();
    // });
    BlocProvider.of<NewsCubit>(context).getNews(const ArticleEntity());
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, PageConst.detailArticlePage,
        arguments: article);
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsCubit>(context).getNews(const ArticleEntity());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Daily News"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => _onShowSavedArticlesViewTapped(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(Icons.bookmark, color: Colors.black),
            ),
          ),
        ],
      ),
      body: BlocProvider.value(
        value: ic.sl<NewsCubit>()..getNews(const ArticleEntity()),
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, newsState) {
            if (newsState is NewsLoading) {
              return Center(child: const CupertinoActivityIndicator());
            }
            if (newsState is NewsLoaded) {
              final news = newsState.news;
              return ListView.builder(
                itemCount: news.length,
                itemBuilder: (_, index) {
                  return ArticleCardWidget(
                    article: news[index],
                    onArticlePressed: (news) =>
                        _onArticlePressed(context, news),
                  );
                },
              );
            }

            return const CupertinoActivityIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          BlocProvider.of<NewsCubit>(context).getNews(const ArticleEntity());
          setState(() {});
          _refreshContent();
        },
        backgroundColor: Colors.deepPurpleAccent,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, PageConst.savedArticlePage);
  }
}
