import 'package:notnetflex/services/api.dart';

class Movie {
  late final int id;
  late final String name;
  late final String description;
  late final String paterPath;
  final List<String>? genre;
  final String? releaseData;
  final double? vote;

  Movie({
    required this.id,
    required this.name,
    required this.description,
    required this.paterPath,
    this.genre,
    this.releaseData,
    this.vote,
  });

  Movie copyWith({
    int? id,
    String? name,
    String? description,
    String? paterPath,
    List<String>? genre,
    String? releaseData,
    double? vote,
  }) {
    return Movie(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      paterPath: paterPath ?? this.paterPath,
      genre: genre ?? this.genre,
      releaseData: releaseData ?? this.releaseData,
      vote: vote ?? this.vote,
    );
  }

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      name: map['title'] ?? '',
      description: map['overview'] ?? '',
      paterPath: map['poster_path'] ?? '',
    );
  }

  String posterURL() {
    API api = API();
    return api.baseImageURL + paterPath;
  }

  String reformateGenre(){
    String categories = '';

    for(int i = 0; i < genre!.length - 1; i++){
      if(i == genre!.length - 1){
        categories = categories + genre![i];
      }else{
        categories = '$categories${genre![i]}, ';
      }
    }
    return categories;
  }
}
