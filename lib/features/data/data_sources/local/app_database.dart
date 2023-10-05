import 'package:floor/floor.dart';

import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:news_app_clean_architecture/features/data/data_sources/local/dao/article_dao.dart';
import 'package:news_app_clean_architecture/features/data/model/article_model.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [ArticleModel])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDAO;
}
