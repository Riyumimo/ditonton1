import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../common/constans.dart';

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({Key? key}) : super(key: key);

  @override
  State<HomeViewPage> createState() => _HomeViewPageState();
}


class _HomeViewPageState extends State<HomeViewPage> {
  @override
void initState() {
  super.initState();
  Future.microtask(
    () => Provider.of<MovieListNotifier>(context ,listen: false)..fetchNowPlayingMovies()..fetchPopularMovies()..fetchTopRatedMovies());
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer : Drawer(child: Column(
        children: [
          UserAccountsDrawerHeader(currentAccountPicture: CircleAvatar(backgroundImage:AssetImage('assets/circle-g.png'))
        , accountEmail: Text("ilhamsuherman802@gmail.com"),
        accountName: Text("Ilham suherman"),
        
        ),
        ListTile(leading: Icon(Icons.home),
        title: Text("Home"),onTap: (){
          Navigator.pop(context);
        },),
        ListTile(leading: Icon(Icons.save_alt),
        title: Text("WishList"),onTap: (){
          //navigator to watchlist
          
        },),
        ListTile(leading: Icon(Icons.info_outline),
        title: Text("About"),onTap: (){
          //navigator going to abgout page
        },),
        ],
      ),)
,
      appBar: AppBar(
        title: Text("Movie Series"),
        actions: [
          IconButton(onPressed: (){
            // going to navigator search movie
          }, icon: Icon(Icons.search))
        ],
      ),
      body: Padding(padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Now Playing",style:TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),
          Consumer<MovieListNotifier>(builder: (context,data,child){
            final state = data.nowPlayingState;
            if (state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if(state == RequestState.Loaded) {
              return MovieList(movies:data.nowPlayingMovies,);
              
            }else{
              return Text("Failed");
            }
          }
          
          ),
          _buildSubHeading(title: "Popular", onTap:(){
            //going to popular page list
          }),
           Consumer<MovieListNotifier>(builder: (context,data,child){
            final state = data.popularMovieState;
            if (state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if(state == RequestState.Loaded) {
              return MovieList(movies:data.popularMovies,);
              
            }else{
              return Text("Failed");
            }
          }
          
          ),
              _buildSubHeading(title: "Top Rated", onTap:(){
            //going to Top Rated page list
          }),
             Consumer<MovieListNotifier>(builder: (context,data,child){
            final state = data.topRateMovieState;
            if (state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if(state == RequestState.Loaded) {
              return MovieList(movies:data.topRateMovies,);
              
            }else{
              return Text("Error");
            }
          }
          
          ),
          
        ],
      )),

    ));
  }
}

Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }


class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList({super.key, required this.movies});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          final movie = movies[index];
          return Container(
            padding: EdgeInsets.all(6),
            child: InkWell(onTap:  () {
              // push page with data here to detail...
            },
              child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(16),),
              child: CachedNetworkImage(imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
              ,placeholder: (context, url )=> Center(child: CircularProgressIndicator(),
                
              ),errorWidget: (context,url,error)=>Icon(Icons.error),)
              
              ),
            ),
            
          );
          
        },
      ),
      
    );
  }

  
}