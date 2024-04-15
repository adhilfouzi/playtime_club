import '../controller/formater.dart';

class UserRequestModel {
  final String userName;
  final String number;
  final String email;
  final String courtName;
  final String location;
  final String description;
  final bool isOwner;

  UserRequestModel(
      {required this.isOwner,
      required this.userName,
      required this.number,
      required this.email,
      required this.courtName,
      required this.location,
      required this.description});

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'number': number,
      'email': email,
      'courtName': courtName,
      'location': location,
      'description': description,
      'isOwner': isOwner,
    };
  }

  // Factory constructor to create UserModel from JSON data
  factory UserRequestModel.fromJson(Map<String, dynamic> json) {
    return UserRequestModel(
      userName: json['userName'],
      number: json['number'],
      email: json['email'],
      courtName: json['courtName'],
      location: json['location'],
      description: json['description'],
      isOwner: json['isOwner'],
    );
  }

  // helper function to fotmat phone number
  String get formattedPhoneNo => Formatter.formatPhoneNumber(number);
  // static function to split full userName into first and last Name
  static List<String> userNameParts(userName) => userName.split('');
}
