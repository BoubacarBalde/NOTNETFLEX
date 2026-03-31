import 'package:notnetflex/services/api.dart';

class Movie {

  late final int id;
  late final String name;
  late final String description;
  late final String paterPath;

  Movie({required this.id, required this.name, required this.description, required this.paterPath });


  Movie copyWith({
    int? id,
    String? name,
    String? description,
    String? paterPath,

  }){
    return Movie(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        paterPath: paterPath ?? this.paterPath
    );
  }

  factory Movie.fromJson(Map<String,dynamic> map){
       return Movie(
         id: map['id'],
         name: map['name'],
         description: map['description'],
         paterPath: map['poster_path'] ,
       );
  }

  String posterURL(){
    API api = API();
    return api.baseImageURL + paterPath;
  }

}