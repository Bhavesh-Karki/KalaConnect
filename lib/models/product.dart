class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.artisanId,
    required this.craftId,
    required this.description,
    required this.materials,
    required this.dimensions,
    required this.makingTime,
    required this.artworkKind,
    required this.imageUrl,
    this.subCategory = '',
  });

  final String id;
  final String name;
  final String category;
  final int price;
  final String artisanId;
  final String craftId;
  final String description;
  final List<String> materials;
  final String dimensions;
  final String makingTime;
  final String artworkKind;
  final String imageUrl;
  final String subCategory;
}
