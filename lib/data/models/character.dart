class Character {
  int id;
  String name;
  String status;
  String species;
  String gender;
  String image;
  String location;
  String type;
  List<String> episode;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.location,
    required this.type,
    required this.episode,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json['id'],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        gender: json["gender"],
        image: json["image"],
        type: json['type'],
        episode: List<String>.from(json["episode"])
            .map(
              (e) =>
                  e.replaceAll('https://rickandmortyapi.com/api/episode/', ''),
            )
            .toList(),
        location: Map<String, String>.from(json["location"])['name']!,
      );
}
