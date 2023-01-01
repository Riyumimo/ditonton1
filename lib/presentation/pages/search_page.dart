import 'package:ditonton/common/constans.dart';
import 'package:ditonton/presentation/provider/search_movie_notofier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../common/state_enum.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                Provider.of<MovieSearchNotifier>(context, listen: false)
                    .fetchMovieSearch(query);
              },
              decoration: InputDecoration(
                hintText: 'Search Title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              "Search Result",
              style: kHeading6,
            ),
            Consumer<MovieSearchNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.state == RequestState.Loaded) {
                  final result = data.searchResult;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: result.length,
                      padding: EdgeInsets.all(8),
                      itemBuilder: (BuildContext context, int index) {
                        final movie = data.searchResult[index];
                        return MovieCard(movie: movie);
                      },
                    ),
                  );
                }
                else{
                  return Expanded(child: Container());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
