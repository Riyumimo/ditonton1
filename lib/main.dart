import 'package:ditonton/presentation/pages/home_view_page.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
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
      ChangeNotifierProvider(create: (_)=> di.locator<MovieListNotifier>(),)
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
    )
    );

    
   
  }
}

