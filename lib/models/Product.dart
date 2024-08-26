class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final List<dynamic> images;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.price,
      required this.images});
  factory Product.fromJson(json) {
    return Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
        price: json["price"],
        images: json["images"]);
  }
}
