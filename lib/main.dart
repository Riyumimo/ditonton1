import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/pages/home_view_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/search_movie_notofier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/constans.dart';
import 'injections.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> di.locator<MovieListNotifier>(),),
      ChangeNotifierProvider(create: (_)=>di.locator<MovieDetailNotifier>(),),
      ChangeNotifierProvider(create: (_)=> di.locator<MovieSearchNotifier>()),
    ],
    child:  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
     
      ),
      home:HomeViewPage(),
      navigatorObservers:[routeObserver],
      onGenerateRoute: (RouteSettings setting){
        switch (setting.name) {
          case '/home':
          return MaterialPageRoute(builder: (context) => HomeViewPage(),);
          case MovieDetailPage.ROUTE_NAME:
          final id = setting.arguments as int;
          return MaterialPageRoute(builder: (context) => MovieDetailPage(id: id),);
          case SearchPage.ROUTE_NAME:
          return MaterialPageRoute(builder: (context) => SearchPage(),);
          default:
            return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
        }
      },
    )
    );

    
   
  }
}

