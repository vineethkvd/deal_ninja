class ProductModel {
  final String id;
  final String name;
  final dynamic price;
  final String imageUrl;
  final String brand;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.brand,
  });

  // Serialize the UserModel instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'brand':brand
    };
  }

  // Create a UserModel instance from a JSON map
  factory ProductModel.fromMap(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: json['price']?? '',
      imageUrl: json['imageUrl'] ?? '',
      brand: json['brand'] ?? '',
    );
  }

}
