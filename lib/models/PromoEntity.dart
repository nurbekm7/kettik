import 'package:kettik/models/UserProfile.dart';
import 'package:kettik/models/UserReview.dart';

//Request to send smth
class PromoEntity {
  final String id;
  final String name;
  final String imageUrl;
  final String description, from, until;
  final double price;
  final UserProfile user;

  PromoEntity(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.description,
      required this.from, // departure city
      required this.until, // крайний срок
      this.price = 0.0,
      required this.user});
}

List<PromoEntity> demoCarts = [
  PromoEntity(
      id: '0',
      name: 'Iphone 14 Pro',
      imageUrl:
          'https://m-cdn.phonearena.com/images/phones/83636-350/Apple-iPhone-14-Pro-Max.jpg',
      description: '+10% за доставку',
      from: 'ОАЭ',
      until: '17.08.2022',
      price: 1000.0,
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
      from: 'ОАЭ',
      until: '17.08.2022',
      price: 5020.0,
      user: UserProfile(
        id: "0",
        name: 'Amir',
        phoneNumber: '+971551141955',
      )),
];
