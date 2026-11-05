class RatingModel {
  final double rate;
  final int count;

  RatingModel({required this.rate, required this.count});

  factory RatingModel.fromJson(dynamic json) {
    // dummyjson → rating is a plain number: "rating": 4.5
    if (json is num) {
      return RatingModel(rate: json.toDouble(), count: 0);
    }
    // fakestoreapi format (kept for compatibility) → "rating": {"rate": 4.5, "count": 120}
    if (json is Map<String, dynamic>) {
      return RatingModel(
        rate: (json['rate'] as num).toDouble(),
        count: (json['count'] as num?)?.toInt() ?? 0,
      );
    }
    return RatingModel(rate: 0.0, count: 0);
  }
}
