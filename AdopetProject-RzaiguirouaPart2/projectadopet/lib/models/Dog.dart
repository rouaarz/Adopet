import 'package:projectadopet/models/Owner.dart';

class Dog {
  final String id;
  final String name;
  final double age;
  final String gender;
  final String color;
  final double weight;
  final String distance;
  final String imageUrl;
  final String description;
  final Owner? owner;

  Dog({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.color,
    required this.weight,
    required this.distance,
    required this.imageUrl,
    required this.description,
    required this.owner,
  });

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: json['_id'] ?? '',
      name: json['name'] ?? 'Unknown',
      age: (json['age'] as num?)?.toDouble() ?? 0.0,
      gender: json['gender'] ?? 'Unknown',
      color: (json['color'] ?? '').toString(),
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      distance: json['distance'] ?? 'Unknown',
      imageUrl: json['imageUrl'],
      description: json['description'] ?? 'No description available',
      owner: json['owner'] != null ? Owner.fromJson(json['owner']) : null,
    );
  }

  Dog copyWith({
    String? id,
    String? name,
    double? age,
    String? gender,
    String? color,
    double? weight,
    String? distance,
    String? imageUrl,
    String? description,
    Owner? owner,
  }) {
    return Dog(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      color: color ?? this.color,
      weight: weight ?? this.weight,
      distance: distance ?? this.distance,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      owner: owner ?? this.owner,
    );
  }
}
