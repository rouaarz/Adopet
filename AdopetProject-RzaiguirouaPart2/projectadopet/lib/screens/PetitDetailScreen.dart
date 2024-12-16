import 'package:flutter/material.dart';
import 'package:projectadopet/models/Dog.dart';
import 'package:projectadopet/models/Owner.dart';

class PetDetailScreen extends StatelessWidget {
  final Dog pet;

  const PetDetailScreen({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
            pet.imageUrl,
          width: double.infinity,
          height: 300,
        fit: BoxFit.cover,
       ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        pet.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: pet.gender == "Male"
                              ? Colors.blue[50]
                              : Colors.pink[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          pet.gender,
                          style: TextStyle(
                            fontSize: 16,
                            color: pet.gender == "Male"
                                ? Colors.blue
                                : Colors.pink,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        pet.distance,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.access_time, color: Colors.grey, size: 16),
                      const SizedBox(width: 4),
                      const Text(
                        "12 min ago",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "${pet.age} yrs | Playful",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "About me",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    pet.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Quick Info",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      QuickInfoItem(label: "Age", value: "${pet.age} yrs"),
                      QuickInfoItem(label: "Color", value: pet.color),
                      QuickInfoItem(label: "Weight", value: "${pet.weight} kg"),
                    ],
                  ),
                   const SizedBox(height: 24),
                  const Text(
                    "Owner Info",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  OwnerInfo(owner: pet.owner),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuickInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const QuickInfoItem({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
class OwnerInfo extends StatelessWidget {
  final Owner? owner;

  const OwnerInfo({Key? key, required this.owner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (owner == null) {
      return Text('Owner information not available');
    }

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            owner!.imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              owner!.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              owner!.bio,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.blue
              ),
            ),
          ],
        ),
      ],
    );
  }
}
