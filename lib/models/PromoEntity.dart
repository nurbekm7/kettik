import 'package:kettik/models/RequestEntity.dart';
import 'package:kettik/models/UserProfile.dart';

//Request to send smth
class PromoEntity {
  String id;
  String name;
  String imageUrl;
  String description;
  Destination from;
  DateTime until;
  int price;
  UserProfile user;

  PromoEntity(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.description,
      required this.from,
      required this.until, // крайний срок
      this.price = 0,
      required this.user});
}
