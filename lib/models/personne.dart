class Personne {
  late final name;
  late final characterName;
  late final String? imageName;

  Personne({
    required this.name,
    required this.characterName,
    this.imageName
  });

  Personne copyWith({String? name, String? characterName, String? imageName}) {
    return Personne(
      name: name ?? this.name,
      characterName: characterName ?? this.characterName,
      imageName: imageName ?? this.imageName,
    );
  }

  factory Personne.fromJson(Map<String, dynamic> map) {
    return Personne(
      name: map['name'],
      characterName: map['character'],
      imageName: map['profile_path'],
    );
  }
}
