import 'package:flutter/material.dart';
import 'package:projectadopet/data/DogService.dart';
import 'package:projectadopet/models/Dog.dart';
import 'package:projectadopet/models/Owner.dart';

class AddDogScreen extends StatefulWidget {
  @override
  _AddDogScreenState createState() => _AddDogScreenState();
}

class _AddDogScreenState extends State<AddDogScreen> {
  final _formKey = GlobalKey<FormState>();
  final DogService dogService = DogService();

  String name = '';
  double age = 0;
  String gender = 'Male';
  String color = '';
  double weight = 0;
  String distance = '';
  String description = '';
  String ownerName = '';
  String ownerBio = '';
  String? selectedDogImage;
  String ownerImage = 'assets/owner.png';

  List<String> dogImageChoices = [
    'assets/orange_dog.png',
    'assets/blue_dog.png',
    'assets/red_dog.png',
    'assets/yellow_dog.png',
    'assets/white_dog.png',
  ];

  void _addDog() async {
    if (_formKey.currentState?.validate() ?? false) {
      String dogImage = selectedDogImage ?? dogImageChoices[0];

      Dog newDog = Dog(
        id: '',
        name: name,
        age: age,
        gender: gender,
        color: color,
        weight: weight,
        distance: distance,
        imageUrl: dogImage,
        description: description,
        owner: Owner(
          name: ownerName,
          bio: ownerBio,
          imageUrl: ownerImage,
        ),
      );

      try {
        await dogService.addDog(newDog);

        Navigator.pop(context);
      } catch (error) {
        print('Erreur lors de l\'ajout du chien: $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erreur lors de l\'ajout du chien.'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Dog'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => name = value,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                onChanged: (value) => age = double.tryParse(value) ?? 0,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the age';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: gender,
                onChanged: (value) => setState(() => gender = value!),
                decoration: InputDecoration(labelText: 'Gender'),
                items: ['Male', 'Female']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Color',
                  labelStyle: TextStyle(color: Colors.blue), // Texte de l'étiquette en bleu
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue), // Bordure bleue
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue), // Bordure bleue quand sélectionné
                  ),
                ),
                onChanged: (value) => color = value,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the color';
                  }
                  return null;
                },
                style: TextStyle(color: Colors.blue), // Texte saisi en bleu
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
                onChanged: (value) => weight = double.tryParse(value) ?? 0,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the weight';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Distance (from location)'),
                onChanged: (value) => distance = value,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the distance';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedDogImage,
                onChanged: (value) => setState(() => selectedDogImage = value),
                decoration: InputDecoration(labelText: 'Select Dog Image'),
                items: dogImageChoices
                    .map((image) => DropdownMenuItem(
                          value: image,
                          child: Image.asset(image, width: 50, height: 50),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an image';
                  }
                  return null;
                },
              ),
              if (selectedDogImage != null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(selectedDogImage!, width: 100, height: 100),
                ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) => description = value,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Owner Name'),
                onChanged: (value) => ownerName = value,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the owner\'s name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Owner Bio'),
                onChanged: (value) => ownerBio = value,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the owner\'s bio';
                  }
                  return null;
                },
              ),
              Image.asset(ownerImage, width: 100, height: 100),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addDog,
                child: Text('Add Dog'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
