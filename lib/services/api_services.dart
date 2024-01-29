import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/models/person.dart';
import 'package:notnetflix/services/api.dart';

class APIService {
  final API api = API();
  final Dio dio = Dio();
  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    //On construit l'url a appeler
    String _url = api.baseURL + path;
    //On construit les parametres de la requette
    //Ces parametres seront presents dans chaque requette
    Map<String, dynamic> query = {
      'api_key': api.apiKey,
      'language': 'fr-FR',
    };
    if (params != null) {
      query.addAll(params);
    }

    //On fait l'appel
    final response = await dio.get(_url, queryParameters: query);
    //On check si la requette est s'est bien passee
    if (response.statusCode == 200)
      return response;
    else
      throw response;
  }

  Future<List<Movie>> getPouplarMovies({required int pageNumber}) async {
    Response response = await getData('/movie/popular', params: {
      'page': pageNumber,
    });
    if (response.statusCode == 200) {
      print("----------------Cheikh--------------------");
      Map data = response.data;
      List<dynamic> results = data['results'];
      List<Movie> movies = [];
      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }
      return movies;
    } else {
      print("----------------Ndiaye--------------------");
      throw response;
    }
  }

  //Now Playing movies
  Future<List<Movie>> getNowPlaying({required int pageNumber}) async {
    Response response = await getData('/movie/now_playing', params: {
      'page': pageNumber,
    });
    if (response.statusCode == 200) {
      print("----------------Cheikh--------------------");
      Map data = response.data;
      /*   List<dynamic> results = data['results'];
      List<Movie> movies = [];
      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }*/
      List<Movie> movies = data['results'].map<Movie>((dynamic moviejson) {
        return Movie.fromJson(moviejson);
      }).toList();
      return movies;
    } else {
      print("----------------Ndiaye--------------------");
      throw response;
    }
  }

  //Upcoming movies
  Future<List<Movie>> getUpcomingMovies({required int pageNumber}) async {
    Response response = await getData('/movie/upcoming', params: {
      'page': pageNumber,
    });
    if (response.statusCode == 200) {
      print("----------------Cheikh--------------------");
      Map data = response.data;
      /*   List<dynamic> results = data['results'];
      List<Movie> movies = [];
      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }*/
      List<Movie> movies = data['results'].map<Movie>((dynamic moviejson) {
        return Movie.fromJson(moviejson);
      }).toList();
      return movies;
    } else {
      print("----------------Ndiaye--------------------");
      throw response;
    }
  }

  Future<List<Movie>> getAnimationMovies({required int pageNumber}) async {
    Response response = await getData('/discover/movie',
        params: {'page': pageNumber, 'with_genres': '16'});
    if (response.statusCode == 200) {
      Map data = response.data;
      /*   List<dynamic> results = data['results'];
      List<Movie> movies = [];
      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }*/
      List<Movie> movies = data['results'].map<Movie>((dynamic moviejson) {
        return Movie.fromJson(moviejson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieDetails({required Movie movie}) async {
    Response reponse = await getData('/movie/${movie.id}');
    if (reponse.statusCode == 200) {
      Map<String, dynamic> _data = reponse.data;
      var genres = _data['genres'] as List;
      List<String> genreList = genres.map((item) {
        return item['name'] as String;
      }).toList();

      Movie newmovie = movie.copyWith(
          genres: genreList,
          releaseDate: _data['release_date'],
          vote: _data['vote_average']);
      return newmovie;
    } else {
      throw reponse;
    }
  }

  Future<Movie> getMovieVideo({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}/videos');
    if (response.statusCode == 200) {
      Map _data = response.data;
      List<String> videoKeys = _data['results'].map<String>((videojson) {
        return videojson['key'] as String;
      }).toList();
      return movie.copyWith(videos: videoKeys);
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieCast({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}/credits');
    if (response.statusCode == 200) {
      Map _data = response.data;
      List<Person> _casting = _data['cast'].map<Person>((dynamic personJson) {
        return Person.fromJson(personJson);
      }).toList();
      return movie.copyWith(casting: _casting);
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieImage({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}/images',
        params: {'include_image_language': 'null'});
    if (response.statusCode == 200) {
      Map _data = response.data;
      List<String> _imagePath =
          _data['backdrops'].map<String>((dynamic imageJson) {
        return imageJson['file_path'];
      }).toList();
      return movie.copyWith(images: _imagePath);
    } else {
      throw response;
    }
  }
}
