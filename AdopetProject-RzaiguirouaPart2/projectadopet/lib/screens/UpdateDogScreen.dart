import 'package:flutter/material.dart';
import 'package:projectadopet/models/Dog.dart';
import 'package:projectadopet/data/DogService.dart';

class UpdateDogScreen extends StatefulWidget {
  final Dog pet;

  UpdateDogScreen({required this.pet});

  @override
  _UpdateDogScreenState createState() => _UpdateDogScreenState();
}

class _UpdateDogScreenState extends State<UpdateDogScreen> {
  final DogService dogService = DogService();

  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _colorController;
  late TextEditingController _weightController;
  late TextEditingController _distanceController;
  late TextEditingController _descriptionController;

  String? selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.pet.name);
    _ageController = TextEditingController(text: widget.pet.age.toString());
    _colorController = TextEditingController(text: widget.pet.color);
    _weightController = TextEditingController(text: widget.pet.weight.toString());
    _distanceController = TextEditingController(text: widget.pet.distance);
    _descriptionController = TextEditingController(text: widget.pet.description);

    selectedImage = widget.pet.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    List<String> dogImageChoices = [
      'assets/orange_dog.png',
      'assets/blue_dog.png',
      'assets/red_dog.png',
      'assets/yellow_dog.png',
      'assets/white_dog.png',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Dog'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.grey[100],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Modifier les détails du chien',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: _nameController,
                    label: 'Nom',
                    icon: Icons.pets,
                  ),
                  SizedBox(height: 15),
                  _buildTextField(
                    controller: _ageController,
                    label: 'Âge',
                    icon: Icons.cake,
                    isNumber: true,
                  ),
                  SizedBox(height: 15),
                  _buildTextField(
                    controller: _colorController,
                    label: 'Couleur',
                    icon: Icons.palette,
                  ),
                  SizedBox(height: 15),
                  _buildTextField(
                    controller: _weightController,
                    label: 'Poids',
                    icon: Icons.line_weight,
                    isNumber: true,
                  ),
                  SizedBox(height: 15),
                  _buildTextField(
                    controller: _distanceController,
                    label: 'Distance',
                    icon: Icons.map,
                  ),
                  SizedBox(height: 15),
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Description',
                    icon: Icons.description,
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: selectedImage,
                    onChanged: (value) {
                      setState(() {
                        selectedImage = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Sélectionner une image',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    items: dogImageChoices
                        .map((image) => DropdownMenuItem(
                              value: image,
                              child: Row(
                                children: [
                                  Image.asset(image, width: 50, height: 50),
                                  SizedBox(width: 10),
                                  Text(image.split('/').last.split('.').first),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                  if (selectedImage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Image.asset(selectedImage!, width: 100, height: 100),
                    ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      if (_nameController.text.isNotEmpty &&
                          _ageController.text.isNotEmpty &&
                          _weightController.text.isNotEmpty) {
                        Dog updatedDog = widget.pet.copyWith(
                          name: _nameController.text,
                          age: double.parse(_ageController.text),
                          color: _colorController.text,
                          weight: double.parse(_weightController.text),
                          distance: _distanceController.text,
                          imageUrl: selectedImage ?? widget.pet.imageUrl,
                          description: _descriptionController.text,
                        );
                        dogService.updateDog(updatedDog);
                        Navigator.pop(context, updatedDog);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Veuillez remplir tous les champs correctement !'),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Mettre à jour',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
