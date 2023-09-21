class Product {
  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.description,
    required this.price,
    required this.quantity,
  });
  final int id;
  final String name;
  final String category;
  final String image;
  final String description;
  final double price;
  final int quantity;
}
