class Owner {
  final String name;
  final String bio;
  final String imageUrl;

  Owner({
    required this.name,
    required this.bio,
    required this.imageUrl,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      name: json['name'] ?? 'Unknown Owner',
      bio: json['bio'] ?? 'No bio available',
      imageUrl: json['imageUrl'] ?? '', // Assurez-vous d'éviter les null
    );
  }
}
