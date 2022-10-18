import 'package:kettik/models/RequestEntity.dart';
import 'package:kettik/models/UserProfile.dart';

//Request to send smth
class PromoEntity {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final Destination from;
  final DateTime until;
  final int price;
  final UserProfile user;

  PromoEntity(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.description,
      required this.from, // departure city
      required this.until, // крайний срок
      this.price = 0,
      required this.user});
}
