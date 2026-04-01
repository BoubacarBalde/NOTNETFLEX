import 'package:dio/dio.dart';
import 'package:notnetflex/models/Movie.dart';
import 'package:notnetflex/services/api.dart';

class APIService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async{
    //On contruit l'url
    String _url = api.baseURL + path;

    //on construit les paramètres de la requete
    //Ces paramètre seront presents dans chaque requestes
    Map<String, dynamic> query = {
      'language': 'fr-FR',
    };

    //Si paramètre n'est pas nul on ajoute son contenu a query
    if(params != null){
      query.addAll(params);
    }

    //on fait l'appel
    final response = await dio.get(
        _url,
        queryParameters: query,
        options: Options(
          headers: {
            'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MjEwYmFkYTk1ZTg2NzYzNzQzN2RlYjdjODBlMDQzZCIsIm5iZiI6MTc3Mzk0NjI0NS45MjQsInN1YiI6IjY5YmM0NTg1YTAyOWFhYmFiMTAwZjc3MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gjfqciWJaNiHVB3mN-PThnxCT4ezud34stuV53WFls0', // 👈 ICI
            'accept': 'application/json',
          },
        ),
    );

    //on check si la raquet c'est bien passé
    if(response.statusCode == 200){
      return response;
    }else{
      throw response;
    }
  }


  Future<List<Movie>> getPopularMovies({required int pageNumber}) async{
    Response response = await getData('movie/popular', params: {
      'page': pageNumber
    });

    if(response.statusCode == 200){
       Map data = response.data;
       List<dynamic> resultats = data['results'];
       List<Movie> movies = [];

       for(Map<String, dynamic> json in resultats){
         Movie movie = Movie.fromJson(json);
         movies.add(movie);
       }

       print(movies);
       return movies;


    }else{
      print(response);
       throw response;

    }
  }

}