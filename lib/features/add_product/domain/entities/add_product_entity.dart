class AddProductEntity {
  final String name;
  final double price;
  final String code;
  final String description;
  final String image;
  final bool isFeatured;
  final String imageUrl;

  AddProductEntity({
    required this.name,
    required this.price,
    required this.code,
    required this.description,
    required this.image,
    required this.isFeatured,
    required this.imageUrl,
  });
}
