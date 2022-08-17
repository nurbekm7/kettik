import 'package:kettik/models/UserReview.dart';

class User {
  final int id;
  final String firstName, lastName, phoneNumber;
  final double rating;
  final bool isBlocked;
  final List<UserReview> userReview;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.userReview,
    this.rating = 0.0,
    this.isBlocked = false,
  });
}
