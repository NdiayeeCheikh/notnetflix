import 'dart:js';

import 'package:flutter/material.dart';
import 'package:notnetflix/repositories/data_repository.dart';
import 'package:notnetflix/ui/screens/home_screen.dart';
import 'package:notnetflix/ui/screens/loading_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context)=>DataRepository(),child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Notnetflix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoadingScreen() ,
    );
  }
}

