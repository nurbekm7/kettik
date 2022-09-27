class UserProfile {
  final String id;
  final String phoneNumber;
  String? name, photoURL;

  UserProfile(
      {required this.id,
      this.name = '',
      required this.phoneNumber,
      this.photoURL = ''});

  // @override
  // String toString() {
  //   return '{'
  //       'name: $name, '
  //       'id: $id, '
  //       'phoneNumber: $phoneNumber, '
  //       'photoURL: $photoURL }';
  // }

  UserProfile.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        phoneNumber = json['phoneNumber'],
        photoURL = json['photoURL'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'phoneNumber': phoneNumber,
        'photoURL': photoURL
      };
}
