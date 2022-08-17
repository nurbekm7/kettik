class UserReview {
  final int id;
  final String text;
  final double rating;
  final String date;

  UserReview({
    required this.id,
    required this.text,
    required this.date,
    this.rating = 0.0,
  });
}
