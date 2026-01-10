import 'dart:convert';

/// Modelo de datos para representar un actor
class Actor {
  int id;
  String name;
  String profilePath;
  String biography;
  String birthday;
  String placeOfBirth;
  double popularity;
  String character;

  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.biography,
    required this.birthday,
    required this.placeOfBirth,
    required this.popularity,
    required this.character,
  });

  /// Crea un Actor desde un Map (respuesta de API)
  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor(
      id: map['id'] as int,
      name: map['name'] ?? '',
      profilePath: map['profile_path'] ?? '',
      biography: map['biography'] ?? '',
      birthday: map['birthday'] ?? '',
      placeOfBirth: map['place_of_birth'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
      character: map['character'] ?? '',
    );
  }

  /// Crea un Actor desde un String JSON
  factory Actor.fromJson(String source) =>
      Actor.fromMap(json.decode(source));
}