
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:notnetflix/repositories/data_repository.dart';
import 'package:notnetflix/ui/screens/home_screen.dart';
import 'package:notnetflix/utils/constant.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState(){
    super.initState();
    initData();
  }
  void initData() async{
    //Appel des api
   final dataProvider=Provider.of<DataRepository>(context,listen: false);
   //On initialise nos listes de movies
   await dataProvider.initData();
   //Ensuite on va vers l'ecran des films ==>home_screen
  // sleep(0.5 as Duration);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return HomeScreen();
    },),);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/netflix_logo_2.png'),
           SpinKitFadingCircle(
             color: kprimaryColor,
             size: 25,
           )
        ],
      ),
    );
  }
}
