import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:notnetflex/services/api_service.dart';
import '../models/Movie.dart';

class DataRepositories with ChangeNotifier{

  final APIService apiService = APIService();
  final List<Movie> _popularMovieList = [];
  int _popularMovieListPageIndex = 1;

  final List<Movie> _nowPlaying = [];
  int _nowPlayingPageIndex = 1;

  final List<Movie> _upcomingMovie = [];
  int _upcommingMoviePageIndex = 1;


  //Getteur
  List<Movie> get popularMovieList => _popularMovieList;
  List<Movie> get nowPlaying => _nowPlaying;
  List<Movie> get upcommingMovie => _upcomingMovie;


  //TODO: Recupereation des films populaire
  Future<void> getPopularMovies() async {

    try{
      List<Movie> movies = await apiService.getPopularMovies(pageNumber:_popularMovieListPageIndex);
      _popularMovieList.addAll(movies);
      _popularMovieListPageIndex++;
      notifyListeners();
    }on Response catch(response) {
      print('ERROR: ${response}');
      rethrow;
    }
  }

  //TODO: Recupereation des films actuellement au cinema
  Future<void> getNowPlaying() async {

    try{
      List<Movie> movies = await apiService.getNowPlaying(pageNumber:_nowPlayingPageIndex);
      _nowPlaying.addAll(movies);
      _nowPlayingPageIndex++;
      notifyListeners();
    }on Response catch(response) {
      print('ERROR: ${response}');
      rethrow;
    }
  }

  //TODO: Recupereation des films qui arrive bien
  Future<void> getUpcommingMovie() async {

    try{
      List<Movie> movies = await apiService.getNowPlaying(pageNumber:_nowPlayingPageIndex);
      _upcomingMovie.addAll(movies);
      _upcommingMoviePageIndex++;
      notifyListeners();
    }on Response catch(response) {
      print('ERROR: ${response}');
      rethrow;
    }
  }

  Future<void> initData() async {
    await getPopularMovies();
    await getNowPlaying();
    await getUpcommingMovie();
  }

}