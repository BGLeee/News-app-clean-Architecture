import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/config/routes/on_generate_route.dart';
import 'package:news_app_clean_architecture/config/theme/theme.dart';
import 'package:news_app_clean_architecture/const.dart';
import 'package:news_app_clean_architecture/features/presentation/cubit/news/cubit/news_cubit.dart';

import 'features/presentation/cubit/local/cubit/local_article_cubit.dart';
import 'package:news_app_clean_architecture/injection_container.dart' as ic;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ic.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: ic.sl<NewsCubit>()),
        BlocProvider.value(value: ic.sl<LocalArticleCubit>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sport News',
        theme: theme(),
        onGenerateRoute: OnGenerateRoute.route,
        initialRoute: PageConst.mainPage,
      ),
    );
  }
}
