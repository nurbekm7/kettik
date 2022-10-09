import 'package:kettik/models/RequestEntity.dart';
import 'package:kettik/models/UserProfile.dart';
import 'package:kettik/models/UserReview.dart';

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

List<PromoEntity> demoCarts = [
  PromoEntity(
      id: '0',
      name: 'Iphone 14 Pro',
      imageUrl:
          'https://m-cdn.phonearena.com/images/phones/83636-350/Apple-iPhone-14-Pro-Max.jpg',
      description: '+10% за доставку',
      from:
          Destination(country: 'Kazakhstan', region: 'Almaty', city: 'Almaty'),
      until: DateTime.parse("2022-10-27 00:00:00.000"),
      price: 1000,
      user: UserProfile(
        id: "0",
        name: 'Timur',
        phoneNumber: '+971551141955',
      )),
  PromoEntity(
      id: '1',
      name: 'Iphone 14 Pro Max',
      imageUrl:
          'https://m-cdn.phonearena.com/images/phones/83636-350/Apple-iPhone-14-Pro-Max.jpg',
      description: '+10% за доставку',
      from:
          Destination(country: 'Kazakhstan', region: 'Almaty', city: 'Almaty'),
      until: DateTime.parse("2022-10-27 00:00:00.000"),
      price: 1000,
      user: UserProfile(
        id: "0",
        name: 'Amir',
        phoneNumber: '+971551141955',
      )),
];
