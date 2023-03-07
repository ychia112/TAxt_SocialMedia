class User{
  final String imagePath;
  final String name;
  final String address;

  const User({
    required this.imagePath,
    required this.name,
    required this.address,
  });

  User copy({
    String? imagePath,
    String? name,
    String? address,
}) =>
    User(
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      address: address ?? this.address,
    );

  static User fromJson(Map<String, dynamic> json) => User(
    imagePath: json['imagePath'],
    name: json['name'],
    address: json['address']
  );

  Map<String, dynamic> toJson() =>{
    'imagePath': imagePath,
    'name': name,
    'address': address,
  };
}