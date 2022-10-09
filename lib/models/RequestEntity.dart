import 'package:kettik/models/UserProfile.dart';
import 'package:get/get.dart';

enum RequestType { sender, courier }

class Destination {
  final String country, region, city;

  Destination(
      {required this.country, required this.region, required this.city});

  Map<String, dynamic> toJson() =>
      {'country': country, 'region': region, 'city': city};
}

//Request to send smth
class RequestEntity {
  String? id;
  final String description;
  final Destination from, to;
  final DateTime deadline;
  final int? price;
  final double? weight;
  final UserProfile user;
  final RequestType requestType;

  RequestEntity(
      {this.id,
      required this.description,
      required this.from, // departure city
      required this.to, // arrival city
      required this.deadline, // last date
      this.price,
      this.weight,
      required this.user,
      required this.requestType});

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'from': from.toJson(),
        'to': to.toJson(),
        'deadline': deadline,
        'price': price,
        'weight': weight,
        'user': user.toJson()
      };
}

List<RequestEntity> demoRequestCarts = [
  RequestEntity(
      id: '0',
      description: '16 августа вылетаю Алматы Дубай возьму посылки',
      from:
          Destination(country: 'Kazakhstan', region: 'Almaty', city: 'Almaty'),
      to: Destination(country: 'UAE', region: 'Dubai', city: 'Dubai'),
      deadline: DateTime.parse("2022-10-27 00:00:00.000"),
      price: 1000,
      weight: 1,
      requestType: RequestType.sender,
      user: UserProfile(
        id: '0',
        name: 'Timur',
        phoneNumber: '+971551141955',
      )),
  RequestEntity(
      id: '1',
      description: 'Нужно отправить телефон до 16 августа из Абу Даби в Алматы',
      from:
          Destination(country: 'Kazakhstan', region: 'Almaty', city: 'Almaty'),
      to: Destination(country: 'UAE', region: 'Dubai', city: 'Dubai'),
      deadline: DateTime.parse("2022-10-27 00:00:00.000"),
      price: 5020,
      weight: 1,
      requestType: RequestType.sender,
      user: UserProfile(
        id: '0',
        name: 'Amir',
        phoneNumber: '+971551141955',
      )),
  RequestEntity(
      id: '2',
      description: '11 август вылетаю Дубай Алматы возьму почту или багаж',
      from:
          Destination(country: 'Kazakhstan', region: 'Almaty', city: 'Almaty'),
      to: Destination(country: 'UAE', region: 'Dubai', city: 'Dubai'),
      deadline: DateTime.parse("2022-10-27 00:00:00.000"),
      price: 0,
      weight: 5,
      requestType: RequestType.sender,
      user: UserProfile(
        id: '0',
        name: 'Nurbek',
        phoneNumber: '+971551141955',
      )),
  RequestEntity(
      id: '2',
      description: '11 август вылетаю Дубай Алматы возьму почту или багаж',
      from:
          Destination(country: 'Kazakhstan', region: 'Almaty', city: 'Almaty'),
      to: Destination(country: 'UAE', region: 'Dubai', city: 'Dubai'),
      deadline: DateTime.parse("2022-10-27 00:00:00.000"),
      price: 0,
      weight: 5,
      requestType: RequestType.sender,
      user: UserProfile(
        id: "0",
        name: 'Nurbek',
        phoneNumber: '+971551141955',
      )),
  RequestEntity(
      id: '2',
      description: '11 август вылетаю Дубай Алматы возьму почту или багаж',
      from:
          Destination(country: 'Kazakhstan', region: 'Almaty', city: 'Almaty'),
      to: Destination(country: 'UAE', region: 'Dubai', city: 'Dubai'),
      deadline: DateTime.parse("2022-10-27 00:00:00.000"),
      price: 0,
      weight: 5,
      requestType: RequestType.sender,
      user: UserProfile(
        id: "0",
        name: 'Nurbek',
        phoneNumber: '+971551141955',
      )),
  RequestEntity(
      id: '2',
      description: '11 август вылетаю Дубай Алматы возьму почту или багаж',
      from:
          Destination(country: 'Kazakhstan', region: 'Almaty', city: 'Almaty'),
      to: Destination(country: 'UAE', region: 'Dubai', city: 'Dubai'),
      deadline: DateTime.parse("2022-10-27 00:00:00.000"),
      price: 0,
      weight: 5,
      requestType: RequestType.sender,
      user: UserProfile(
        id: "0",
        name: 'Nurbek',
        phoneNumber: '+971551141955',
      )),
];
