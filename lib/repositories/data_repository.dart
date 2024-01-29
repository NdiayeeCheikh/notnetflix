import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/services/api_services.dart';

class DataRepository with ChangeNotifier {
  APIService apiService = APIService();
  final List<Movie> _popularMovieList = [];
  int _nowPlayingPageIndex = 1;

  final List<Movie> _nowPlaying = [];
  int _popularMoviePageIndex = 1;

  final List<Movie> _upcomingMovies = [];
  int _upcomingMoviePageIndex = 1;

  final List<Movie> _animationMovies = [];
  int _animationMoviesPageIndex = 1;

  //getters
  List<Movie> get popularMovieList => _popularMovieList;
  List<Movie> get nowPlayingList => _nowPlaying;
  List<Movie> get upcomingMovies => _upcomingMovies;
  List<Movie> get animatioMovies => _animationMovies;

  Future<void> getPopularMovies() async {
    try {
      List<Movie> movies =
          await apiService.getPouplarMovies(pageNumber: _popularMoviePageIndex);
      _popularMovieList.addAll(movies);
      _popularMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("Error:${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getNowPlaying() async {
    try {
      List<Movie> movies =
          await apiService.getNowPlaying(pageNumber: _nowPlayingPageIndex);
      _nowPlaying.addAll(movies);
      _nowPlayingPageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("Error:${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getUpcomingMovies() async {
    try {
      List<Movie> movies = await apiService.getUpcomingMovies(
          pageNumber: _upcomingMoviePageIndex);
      _upcomingMovies.addAll(movies);
      _upcomingMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("Error:${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getAnimationMovies() async {
    try {
      List<Movie> movies = await apiService.getAnimationMovies(
          pageNumber: _animationMoviesPageIndex);
      _animationMovies.addAll(movies);
      _animationMoviesPageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("Error:${response.statusCode}");
      rethrow;
    }
  }

  Future<Movie> getMovieDetails({required Movie movie}) async {
    try {
      //On recupere ici les infos du film
      Movie newmovie = await apiService.getMovieDetails(movie: movie);
      //On va recuprer les videos + des infos qu'on avait avant
      newmovie = await apiService.getMovieVideo(movie: newmovie);
      //On va recuperer les casting
      newmovie = await apiService.getMovieCast(movie: newmovie);
      //On va recuprer les images du film
      newmovie = await apiService.getMovieImage(movie: newmovie);
      return newmovie;
    } on Response catch (response) {
      print("EROOR:${response.statusCode}");
      rethrow;
    }
  }

  Future<void> initData() async {
    /*  await getPopularMovies();
    await getNowPlaying();
    await getUpcomingMovies();
    await getAnimationMovies();*/
    //Cette methode est plu rapide
    await Future.wait([
      getPopularMovies(),
      getAnimationMovies(),
      getUpcomingMovies(),
      getNowPlaying(),
    ]);
  }
}
