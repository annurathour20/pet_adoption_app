class Pet {
  final String name;
  final int age;
  final double price;
  final String imageUrl;
  bool isAdopted;

  Pet({
    required this.name,
    required this.age,
    required this.price,
    required this.imageUrl,
    this.isAdopted = false,
  });
}
