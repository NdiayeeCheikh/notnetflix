
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notnetflix/utils/constant.dart';



class ActionButton extends StatelessWidget {
  final String label;
  final iconData;
  final bgColor;
  final Color color;
   ActionButton({super.key,
     required this.label,
     required this.bgColor,
     required this.color,
     required this.iconData
   });

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 30,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: bgColor
        ),
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData,color: kBackgroundColor,),
            SizedBox(width: 5,),
            Text(
              label,
              style: GoogleFonts.poppins(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),
            ),
          ],
        ),
      );
  }
}
