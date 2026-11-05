import 'package:storeapp/features/products/data/models/rating_model.dart';

class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingModel? rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // dummyjson uses 'thumbnail'; fakestoreapi uses 'image' — support both
    final String image =
        (json['thumbnail'] as String?) ??
        (json['image'] as String?) ??
        '';

    return ProductModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      image: image,
      rating: json['rating'] != null
          ? RatingModel.fromJson(json['rating'])
          : null,
    );
  }
}
