import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projectadopet/models/Dog.dart';

class DogService {
  final String apiUrl = 'http://localhost:3000/api/dogs';

  Future<List<Dog>> fetchDogs() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        if (data.isNotEmpty) {
          return data.map((dog) {
            try {
              return Dog.fromJson(dog);
            } catch (e) {
              print('Error parsing dog: $e');
              return null;
            }
          }).whereType<Dog>().toList();
        } else {
          throw Exception('No data available');
        }
      } else {
        throw Exception('Failed to load dogs: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching dogs: $e');
      rethrow;
    }
  }
   Future<void> addDog(Dog newDog) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'name': newDog.name,
          'age': newDog.age,
          'gender': newDog.gender,
          'color': newDog.color,
          'weight': newDog.weight,
          'distance': newDog.distance,
          'imageUrl': newDog.imageUrl,
          'description': newDog.description,
          'owner': {
            'name': newDog.owner?.name,
            'bio': newDog.owner?.bio,
            'imageUrl': newDog.owner?.imageUrl,
          },
        }),
      );

      if (response.statusCode == 201) {
        print('Dog added successfully');
      } else {
        throw Exception('Failed to add dog: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding dog: $e');
      rethrow;
    }
  }
  Future<void> updateDog(Dog dog) async {
  try {
    final response = await http.put(
      Uri.parse('$apiUrl/${dog.id}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'name': dog.name,
        'age': dog.age,
        'gender': dog.gender,
        'color': dog.color,
        'weight': dog.weight,
        'distance': dog.distance,
        'imageUrl': dog.imageUrl,
        'description': dog.description,
        'owner': {
          'name': dog.owner?.name,
          'bio': dog.owner?.bio,
          'imageUrl': dog.owner?.imageUrl,
        },
      }),
    );

    if (response.statusCode == 200) {
      print('Dog updated successfully');
    } else {
      throw Exception('Failed to update dog: ${response.statusCode}');
    }
  } catch (e) {
    print('Error updating dog: $e');
    rethrow;
  }
}

Future<void> deleteDog(String dogId) async {
  try {
    final response = await http.delete(
      Uri.parse('$apiUrl/$dogId'),
    );

    if (response.statusCode == 200) {
      print('Dog deleted successfully');
    } else {
      throw Exception('Failed to delete dog: ${response.statusCode}');
    }
  } catch (e) {
    print('Error deleting dog: $e');
    rethrow;
  }
}
}
