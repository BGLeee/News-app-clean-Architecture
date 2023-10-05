import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:news_app_clean_architecture/features/domain/entities/article_entity.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:news_app_clean_architecture/features/presentation/cubit/local/cubit/local_article_cubit.dart';

class DetailArticlePage extends StatefulWidget {
  final ArticleEntity? article;

  const DetailArticlePage({Key? key, this.article});

  @override
  State<DetailArticlePage> createState() => _DetailArticlePageState();
}

class _DetailArticlePageState extends State<DetailArticlePage> {
  String? articleContent = "";
  @override
  void initState() {
    super.initState();
    log("${widget.article!.id}");

    // URL of the article you want to scrape
    String articleUrl = widget.article!.articleUrl!;

    // Make a GET request to fetch the HTML content of the article
    http.get(Uri.parse(articleUrl)).then((response) {
      if (response.statusCode == 200) {
        // Parse the HTML content using html package
        var document = html.parse(response.body);

        // Extract article content based on the HTML structure
        var paragraphs = document.querySelectorAll(
            'p'); // Adjust the selector based on the HTML structure of the article

        // Combine paragraphs into the article content
        setState(() {
          articleContent = paragraphs.map((p) => p.text).join('\n');
        });
      } else {
        print('Failed to load the article.');
      }
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(Ionicons.chevron_back, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildArticleTitleAndDate(),
          widget.article!.imageUrl == null
              ? Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                  ),
                  child: const Icon(Icons.error),
                )
              : _buildArticleImage(),
          _buildArticleDescription(),
        ],
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            widget.article!.title ?? "",
            style: const TextStyle(
                fontFamily: 'Butler',
                fontSize: 20,
                fontWeight: FontWeight.w900),
          ),

          const SizedBox(height: 14),
          // DateTime
          Row(
            children: [
              const Icon(Ionicons.time_outline, size: 16),
              const SizedBox(width: 4),
              Text(
                widget.article!.publishedAt! ?? "",
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArticleImage() {
    return Container(
      width: double.maxFinite,
      height: 250,
      margin: const EdgeInsets.only(top: 14),
      child: CachedNetworkImage(
          imageUrl: widget.article!.imageUrl!,
          imageBuilder: (context, imageProvider) => Padding(
                padding: const EdgeInsetsDirectional.only(end: 14),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.08),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                ),
              ),
          progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
                padding: const EdgeInsetsDirectional.only(end: 14),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                    ),
                    child: const CupertinoActivityIndicator(),
                  ),
                ),
              ),
          errorWidget: (context, url, error) => Padding(
                padding: const EdgeInsetsDirectional.only(end: 14),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                    ),
                    child: const Icon(Icons.error),
                  ),
                ),
              )),
      //Image.network(widget.article!.imageUrl!, fit: BoxFit.cover),
    );
  }

  Widget _buildArticleDescription() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          child: Text(
            '${widget.article!.description ?? ''}\n\n${articleContent ?? ''}',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        articleContent!.isEmpty
            ? CupertinoActivityIndicator()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
                child: Text(
                  '\n${articleContent ?? ''}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () => _onFloatingActionButtonPressed(context),
        child: const Icon(Ionicons.bookmark, color: Colors.white),
      ),
    );
  }

  void _onFloatingActionButtonPressed(BuildContext context) async {
    BlocProvider.of<LocalArticleCubit>(context).saveArticles(widget.article!);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text('Article saved successfully.'),
      ),
    );
  }

  // Widget _buildFloatingActionButton() {
  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }
}
