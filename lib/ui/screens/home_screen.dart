import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/repositories/data_repository.dart';
import 'package:notnetflix/services/api_services.dart';
import 'package:notnetflix/ui/screens/widgets/movie_card.dart';
import 'package:notnetflix/ui/screens/widgets/movie_category.dart';
import 'package:notnetflix/utils/constant.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final dataProvider=Provider.of<DataRepository>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: Image.asset('assets/images/netflix_logo_2.png'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 500,
           // color: Colors.red,
            child: dataProvider.popularMovieList.isEmpty ? const Center() : MovieCard(movie: dataProvider.popularMovieList.first),
          //  Image.network(dataProvider.popularMovieList[1].posterURL(),fit: BoxFit.cover,
         ),
          const SizedBox(
            height: 15,
          ),
       /*   Text(
            "Tendances actuelles",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 160,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext, int index){
                  return Container(
                    width: 110,
                    margin: const EdgeInsets.only(right: 8),
                    color: Colors.yellow,
                    child: Center(
                      child: dataProvider.popularMovieList.isEmpty ?  Text(index.toString()):
                     // Image.network(dataProvider.popularMovieList[index].posterURL(),fit: BoxFit.cover,
                      MovieCard(movie: dataProvider.popularMovieList[index]),
                      ),
                  );
                }),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Actuellement au Cinema",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          )*/
          MovieCategory(
              imageHeight: 160,
              imageWidth: 110,
              label: "Nouvelles Tendances",
              movieList: dataProvider.popularMovieList,
              callback: dataProvider.getPopularMovies,
          ),

          MovieCategory(
              imageHeight: 320,
              imageWidth: 220,
              label: "Actuellement au Cinema",
              movieList: dataProvider.nowPlayingList,
              callback: dataProvider.getNowPlaying,
          ),

          MovieCategory(
            imageHeight: 320,
            imageWidth: 220,
            label: "Ils arrivent bientot",
            movieList: dataProvider.upcomingMovies,
            callback: dataProvider.getUpcomingMovies,
          ),
          MovieCategory(
            imageHeight: 320,
            imageWidth: 220,
            label: "Animation",
            movieList: dataProvider.animatioMovies,
            callback: dataProvider.getAnimationMovies,
          ),
          const SizedBox(
            height: 5,
          ),
      //    MovieCategory(imageHeight: 160, imageWidth: 110, label: "Ils arrivent bientot", movieList: dataProvider.popularMovieList),
        ],
      ),
    );
  }
}
