import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notnetflix/models/movie.dart';

class MovieInfo extends StatelessWidget {
  final Movie movie;
   MovieInfo({super.key,
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10,),
        Text(
          movie!.name,
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 5,),
        Text(
          'Genres:${movie!.reformatGenres()}',
          style: GoogleFonts.poppins(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 5,),
        Row(
          children: [
            Container(
              padding:const EdgeInsets.symmetric(vertical: 2,horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius:BorderRadius.circular(5)
              ),
              child: Text(
                movie!.releaseDate!.substring(0,4),
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 12
                ),
              ),
            ),
            const SizedBox(width: 5,),
            Text(
              "Recommande a ${(movie!.vote!*10).toInt()}%",
              style: GoogleFonts.poppins(
                  color: Colors.green,
                  fontSize: 14,
                  fontWeight: FontWeight.w500
              ),
            )
          ],
        )
      ],
    );
  }
}
