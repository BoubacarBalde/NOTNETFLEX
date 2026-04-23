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

  final List<Movie> _animationMovie = [];
  int _animationMoviePageIndex = 1;


  //Getteur
  List<Movie> get popularMovieList => _popularMovieList;
  List<Movie> get nowPlaying => _nowPlaying;
  List<Movie> get upcommingMovie => _upcomingMovie;
  List<Movie> get animationMovie => _animationMovie;


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
      List<Movie> movies = await apiService.getNowPlaying(pageNumber:_upcommingMoviePageIndex);
      _upcomingMovie.addAll(movies);
      _upcommingMoviePageIndex++;
      notifyListeners();
    }on Response catch(response) {
      print('ERROR: ${response}');
      rethrow;
    }
  }

  //TODO: Recupereation des films Animé par Categorie
  Future<void> getAnimationMovie() async {

    try{
      List<Movie> movies = await apiService.getAnimationMovie(pageNumber:_animationMoviePageIndex);
      _animationMovie.addAll(movies);
      _animationMoviePageIndex++;
      notifyListeners();
    }on Response catch(response) {
      print('ERROR: ${response}');
      rethrow;
    }
  }

  //TODO: Recupereation des Details d'un fim
  Future<Movie> getMovieDetails({required Movie movie}) async{
   try{
     //On recupere les infos du film
     Movie newMovie = await apiService.getMovieDetails(movie: movie);

     //On recupere les video du film
     newMovie = await apiService.getMovieVideos(movie: newMovie);

     //On recupere les casting du film
     newMovie = await apiService.getMovieCasting(movie: newMovie);

     //on recupere les images du films
     newMovie = await apiService.getMovieImage(movie: newMovie);

     return newMovie;
   }on Response catch(response){
     print('ERROR: ${response.statusCode}');
     throw response;
   }
    
  }
  
  Future<void> initData() async {
    await Future.wait([
      getPopularMovies(),
      getNowPlaying(),
      getUpcommingMovie(),
      getAnimationMovie(),
    ]);
  }

}