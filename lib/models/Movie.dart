mixin Movie {

  late final int id;
  late final String name;
  late final String description;
  late final String paterPath;

  Movie({required this.id, required this.nom, required this.description, this.paterPath });


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

}