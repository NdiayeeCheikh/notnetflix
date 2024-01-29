


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/ui/screens/widgets/movie_card.dart';

class MovieCategory extends StatelessWidget {
  final String label;
  final List<Movie> movieList;
  final double imageHeight;
  final double imageWidth;
  final Function callback;
   MovieCategory({super.key,
     required this.imageHeight,
     required this.imageWidth,
     required this.label,
     required this.movieList,
     required this.callback
   });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label",
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: imageHeight,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification){
              final currentPosition=notification.metrics.pixels;
              print("Current Position=${currentPosition}");
              final maxPosition=notification.metrics.maxScrollExtent;
              print("Max Position=${maxPosition}");
              if(currentPosition >= maxPosition/2){
                print("On est arrive au bout de la liste");
                //Recuperer les autres film de pour l'afficher
                callback();

              }
              return true;
            },
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:movieList.length,
                itemBuilder: (BuildContext, int index){
                  return Container(
                    width: imageWidth,
                    margin: const EdgeInsets.only(right: 8),
                 //   color: Colors.yellow,
                    child: Center(
                      child: movieList.isEmpty ?  Text(index.toString()):
                      // Image.network(dataProvider.popularMovieList[index].posterURL(),fit: BoxFit.cover,
                      MovieCard(movie: movieList[index]),
                    ),
                  );
                }),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
