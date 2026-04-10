import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:notnetflex/services/api_service.dart';
import '../models/Movie.dart';

class DataRepositories with ChangeNotifier{

  final APIService apiService = APIService();
  final List<Movie> _popularMovieList = [];
  int _popularMovieListPageIndex = 1;


  //Getteur
  List<Movie> get popularMovieList => _popularMovieList;

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

  Future<void> initData() async {
    await getPopularMovies();
  }

}