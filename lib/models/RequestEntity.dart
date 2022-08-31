import 'package:kettik/models/User.dart';
import 'package:kettik/models/UserReview.dart';

//Request to send smth
class RequestEntity {
  final String id;
  final String description, from, to, toTime;
  final double price, weight;
  final bool isFavourite;
  final User user;

  RequestEntity(
      {required this.id,
      required this.description,
      required this.from, // departure city
      required this.to, // arrival city
      required this.toTime, // крайний срок
      this.price = 0.0,
      this.weight = 0.0,
      this.isFavourite = false,
      required this.user});
}

List<RequestEntity> demoCarts = [
  RequestEntity(
      id: '0',
      description: '16 августа вылетаю Алматы Дубай возьму посылки',
      from: 'Almaty',
      to: 'Dubai',
      toTime: '17.08.2022',
      price: 1000.0,
      weight: 1,
      user: User(
          id: 0,
          firstName: 'Timur',
          lastName: 'Rodriges',
          phoneNumber: '+971551141955',
          rating: 3.0,
          userReview: [
            UserReview(id: 0, text: 'init', date: '01.01.2022', rating: 5.0)
          ])),
  RequestEntity(
      id: '1',
      description: 'Нужно отправить телефон до 16 августа из Абу Даби в Алматы',
      from: 'Almaty',
      to: 'Dubai',
      toTime: '17.08.2022',
      price: 5020.0,
      weight: 1,
      user: User(
          id: 0,
          firstName: 'Amir',
          lastName: 'Zhakypov',
          phoneNumber: '+971551141955',
          rating: 1.0,
          userReview: [
            UserReview(id: 0, text: 'init', date: '01.01.2022', rating: 5.0)
          ])),
  RequestEntity(
      id: '2',
      description: '11 август вылетаю Дубай Алматы возьму почту или багаж',
      from: 'Almaty',
      to: 'Dubai',
      toTime: '2.08.2022',
      price: 0.0,
      weight: 5,
      user: User(
          id: 0,
          firstName: 'Nurbek',
          lastName: 'Mussa',
          phoneNumber: '+971551141955',
          rating: 5.0,
          userReview: [
            UserReview(id: 0, text: 'init', date: '01.01.2022', rating: 5.0)
          ])),
  RequestEntity(
      id: '2',
      description: '11 август вылетаю Дубай Алматы возьму почту или багаж',
      from: 'Almaty',
      to: 'Dubai',
      toTime: '2.08.2022',
      price: 0.0,
      weight: 5,
      user: User(
          id: 0,
          firstName: 'Nurbek',
          lastName: 'Mussa',
          phoneNumber: '+971551141955',
          rating: 5.0,
          userReview: [
            UserReview(id: 0, text: 'init', date: '01.01.2022', rating: 5.0)
          ])),
  RequestEntity(
      id: '2',
      description: '11 август вылетаю Дубай Алматы возьму почту или багаж',
      from: 'Almaty',
      to: 'Dubai',
      toTime: '2.08.2022',
      price: 0.0,
      weight: 5,
      user: User(
          id: 0,
          firstName: 'Nurbek',
          lastName: 'Mussa',
          phoneNumber: '+971551141955',
          rating: 5.0,
          userReview: [
            UserReview(id: 0, text: 'init', date: '01.01.2022', rating: 5.0)
          ])),
  RequestEntity(
      id: '2',
      description: '11 август вылетаю Дубай Алматы возьму почту или багаж',
      from: 'Almaty',
      to: 'Dubai',
      toTime: '2.08.2022',
      price: 0.0,
      weight: 5,
      user: User(
          id: 0,
          firstName: 'Nurbek',
          lastName: 'Mussa',
          phoneNumber: '+971551141955',
          rating: 5.0,
          userReview: [
            UserReview(id: 0, text: 'init', date: '01.01.2022', rating: 5.0)
          ])),
];
