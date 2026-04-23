import 'package:dio/dio.dart';
import 'package:notnetflex/models/Movie.dart';
import 'package:notnetflex/models/personne.dart';
import 'package:notnetflex/services/api.dart';

class APIService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    //On contruit l'url
    String _url = api.baseURL + path;

    //on construit les paramètres de la requete
    //Ces paramètre seront presents dans chaque requestes
    Map<String, dynamic> query = {'language': 'fr-FR'};

    //Si paramètre n'est pas nul on ajoute son contenu a query
    if (params != null) {
      query.addAll(params);
    }

    //on fait l'appel
    final response = await dio.get(
      _url,
      queryParameters: query,
      options: Options(
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MjEwYmFkYTk1ZTg2NzYzNzQzN2RlYjdjODBlMDQzZCIsIm5iZiI6MTc3Mzk0NjI0NS45MjQsInN1YiI6IjY5YmM0NTg1YTAyOWFhYmFiMTAwZjc3MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gjfqciWJaNiHVB3mN-PThnxCT4ezud34stuV53WFls0',
          'accept': 'application/json',
        },
      ),
    );

    //on check si la raquet c'est bien passé
    if (response.statusCode == 200) {
      return response;
    } else {
      throw response;
    }
  }

  //TODO: Fonction pour recuperer les fils populaire
  Future<List<Movie>> getPopularMovies({required int pageNumber}) async {
    Response response = await getData(
      '/movie/popular',
      params: {'page': pageNumber},
    );

    if (response.statusCode == 200) {
      Map data = response.data;
      List<dynamic> resultats = data['results'];
      List<Movie> movies = [];

      for (Map<String, dynamic> json in resultats) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }

      print(movies);
      return movies;
    } else {
      print(response);
      throw response;
    }
  }

  //TODO: Fonction pour recupere les films qui sont actuellement au cinema
  Future<List<Movie>> getNowPlaying({required int pageNumber}) async {
    Response response = await getData(
      '/movie/now_playing',
      params: {'page': pageNumber},
    );

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic moviJson) {
        return Movie.fromJson(moviJson);
      }).toList();

      return movies;
    } else {
      print(response);
      throw response;
    }
  }

  //TODO: Fonction pour recupere les films qui arrive bientot
  Future<List<Movie>> getUpcomingMovie({required int pageNumber}) async {
    Response response = await getData(
      '/movie/upcoming',
      params: {'page': pageNumber},
    );

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic moviJson) {
        return Movie.fromJson(moviJson);
      }).toList();

      return movies;
    } else {
      print(response);
      throw response;
    }
  }

  //TODO: Fonction pour recupere les films par Categorie Animé
  Future<List<Movie>> getAnimationMovie({required int pageNumber}) async {
    Response response = await getData(
      '/discover/movie',
      params: {'page': pageNumber, 'with_genres': '16'},
    );

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic moviJson) {
        return Movie.fromJson(moviJson);
      }).toList();

      return movies;
    } else {
      print(response);
      throw response;
    }
  }

  //   //TODO: Fonction pour recupere les details d'un film
  //   Future<Movie> getMovieDetails({required Movie movie}) async {
  //     Response response = await getData('/movie/${movie.id}');
  //
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> _data = response.data;
  //       var genres = _data['genres'] as List;
  //       List<String> genreList = genres.map((item) {
  //         return item['name'] as String;
  //       }).toList();
  //
  //       Movie newMovie = movie.copyWith(
  //         genre: genreList,
  //         releaseData: _data['release_date'],
  //         vote: _data['vote_average'],
  //       );
  //
  //       return newMovie;
  //     } else {
  //       throw response;
  //     }
  //   }
  //
  //   //TODO: Fonction pour recupere les Video d'un film
  //   Future<Movie> getMovieVideos({required Movie movie}) async {
  //     Response response = await getData('/movie/${movie.id}/videos');
  //
  //     if (response.statusCode == 200) {
  //       Map _data = response.data;
  //
  //       List<String> videoKey = _data['results'].map<String>((videoJson) {
  //         return videoJson['key'] as String;
  //       }).toList();
  //
  //       return movie.copyWith(videos: videoKey);
  //     } else {
  //       throw response;
  //     }
  //   }
  //
  //   //TODO: Fonction pour recupere les Personnage du films
  //   Future<Movie> getMovieCasting({required Movie movie}) async {
  //     Response response = await getData('/movie/${movie.id}/credits');
  //     if (response.statusCode == 200) {
  //       Map _data = response.data;
  //
  //       List<Personne> _casting = _data['cast'].map<Personne>((dynamic personJson,) {
  //         return Personne.fromJson(personJson);
  //       }).toList();
  //
  //       return movie.copyWith(casting: _casting);
  //     } else {
  //       throw response;
  //     }
  //   }
  //
  // //TODO: Fonction pour recupere les photo du films
  //  Future<Movie> getMovieImage({required Movie movie}) async{
  //     Response response = await getData('/movie/${movie.id}/images', params: {
  //       'include_image_language':'null',
  //     });
  //
  //     if(response.statusCode == 200){
  //       //on recupere toutes les images
  //       Map _data = response.data;
  //       List<String> imagePath = _data['backdrops'].map<String>((dynamic imageJson){
  //          return imageJson['file_path'] as String;
  //       }).toList();
  //
  //       return movie.copyWith(images: imagePath);
  //
  //     }else{
  //       throw response;
  //     }
  //  }

  //TODO: Fonction pour recupere touts les detaille du films
  Future<Movie> getMovie({required Movie movie}) async {
    Response response = await getData(
      '/movie/${movie.id}',
      params: {
        'append_to_response': 'videos,credits,images',
        'include_image_language': 'null',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> _data = response.data;

      //On recupere les genre
      var genres = _data['genres'] as List;
      List<String> genreList = genres.map((item) {
        return item['name'] as String;
      }).toList();

      //On recupere les video
      List<String> videoKey = _data['videos']['results'].map<String>((
        videoJson,
      ) {
        return videoJson['key'] as String;
      }).toList();

      //On recupere les photo utilisateur
      List<Personne> _casting = _data['credits']['cast'].map<Personne>((
        dynamic personJson,
      ) {
        return Personne.fromJson(personJson);
      }).toList();

      //On Recupere les photos du film
      List<String> imagePath = _data['images']['backdrops'].map<String>((
        dynamic imageJson,
      ) {
        return imageJson['file_path'] as String;
      }).toList();

      return movie.copyWith(
        genre: genreList,
        videos: videoKey,
        casting: _casting,
        images: imagePath,
        releaseData: _data['release_date'],
        vote: _data['vote_average'],
      );
    } else {
      throw response;
    }
  }
}
