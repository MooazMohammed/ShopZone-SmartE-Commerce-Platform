import 'package:storeapp/models/rating_model.dart';

class ProductModel {
  final String image;
  final int id;
  final String title;
  final String description;
  final dynamic price;
  final String category;

  final RatingModel ?rating;
  

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.category,
    required this.description,
    required this.rating,
  });

  
  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductModel(
      id: jsonData['id'],
      title: jsonData['title'],
      price: jsonData['price'],
      image: jsonData['image'],
      category: jsonData['category'],
      description: jsonData['description'],
      rating: jsonData['rating'] == null 
      ? null 
      : RatingModel.fromJson(jsonData['rating']),
    );
  }
}
