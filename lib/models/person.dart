import 'dart:convert';

class Person {
  final String name;
  final String characterPerson;
  final String? imageURL;
  Person({
    required this.name,
    required this.characterPerson,
    this.imageURL,
  });

  



  Person copyWith({
    String? name,
    String? characterPerson,
    String? imageURL,
  }) {
    return Person(
      name: name ?? this.name,
      characterPerson: characterPerson ?? this.characterPerson,
      imageURL: imageURL ?? this.imageURL,
    );
  }


  factory Person.fromJson(Map<String, dynamic> map) {
    return Person(
      name: map['name'] ?? '',
      characterPerson: map['character'] ?? '',
      imageURL: map['profile_path'],
    );
  }

}
