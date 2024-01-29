import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/repositories/data_repository.dart';
import 'package:notnetflix/ui/screens/widgets/action_button.dart';
import 'package:notnetflix/ui/screens/widgets/casting_card.dart';
import 'package:notnetflix/ui/screens/widgets/galerie_card.dart';
import 'package:notnetflix/ui/screens/widgets/movie_info.dart';
import 'package:notnetflix/ui/screens/widgets/my_video_player.dart';
import 'package:notnetflix/utils/constant.dart';
import 'package:provider/provider.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailsPage({super.key, required this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Movie? newmovie;
  @override
  void initState() {
    super.initState();
    getMovieData();
  }

  void getMovieData() async {
    final dateProvider = Provider.of<DataRepository>(context, listen: false);
    //Recupere les details du movie
    Movie _movie = await dateProvider.getMovieDetails(movie: widget.movie);
    setState(() {
      newmovie = _movie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
      ),
      body: newmovie == null
          ? Center(
              child: SpinKitFadingCircle(
                color: kprimaryColor,
                size: 20,
              ),
            )
          : Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    child: MyVideoPlayer(movieId: newmovie!.videos!.first),
                  ),
                  //    MovieInfo(movie: newmovie!),
                  SizedBox(
                    height: 5,
                  ),
                  ActionButton(
                      label: 'lecture',
                      bgColor: Colors.white,
                      color: kBackgroundColor,
                      iconData: Icons.play_arrow),
                  SizedBox(
                    height: 5,
                  ),
                  ActionButton(
                      label: 'Telecharger la video',
                      bgColor: Colors.grey.withOpacity(0.3),
                      color: Colors.white,
                      iconData: Icons.download),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    newmovie!.description,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Casting',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                        itemCount: newmovie!.casting!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return newmovie!.casting![index].imageURL == null
                              ? Center()
                              : CastingCard(person: newmovie!.casting![index]);
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
  
                  Text(
                    'Galery',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                        itemCount: newmovie!.images!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GalerieCard(posterPath:newmovie!.images![index]);
                        }),
                  )
                ],
              ),
            ),
    );
  }
}
