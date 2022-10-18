import 'package:kettik/models/UserProfile.dart';

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
