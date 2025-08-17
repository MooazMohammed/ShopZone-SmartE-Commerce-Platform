class RatingModel {
  final dynamic rate;
  final int count;

  RatingModel({
    required this.rate,
    required this.count,
  });

  factory RatingModel.fromJson(jsonData) {
    return RatingModel(
      rate: jsonData['rate'].toDouble(),
      count: jsonData['count'],
    );
  }
}
