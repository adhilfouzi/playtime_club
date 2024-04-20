import '../controller/formater.dart';

class UserModel {
  final String courtName;
  final String courtPhoneNumber;
  final String courtEmailAddress;
  final String courtDescription;
  final String openingTime;
  final String closingTime;
  final String courtLocation;
  final String images;
  final String ownerPhoto;
  final String ownerFullName;
  final String ownerPhoneNumber;
  final String ownerEmailAddress;
  final bool isOwner;
  final bool isRegistered;

  UserModel({
    required this.courtName,
    required this.courtPhoneNumber,
    required this.courtEmailAddress,
    required this.courtDescription,
    required this.openingTime,
    required this.closingTime,
    required this.courtLocation,
    required this.images,
    required this.ownerPhoto,
    required this.ownerFullName,
    required this.ownerPhoneNumber,
    required this.ownerEmailAddress,
    required this.isOwner,
    required this.isRegistered,
  });

  Map<String, dynamic> toJson() {
    return {
      'courtName': courtName,
      'courtPhoneNumber': courtPhoneNumber,
      'courtEmailAddress': courtEmailAddress,
      'courtDescription': courtDescription,
      'openingTime': openingTime,
      'closingTime': closingTime,
      'courtLocation': courtLocation,
      'images': images,
      'ownerPhoto': ownerPhoto,
      'ownerFullName': ownerFullName,
      'ownerPhoneNumber': ownerPhoneNumber,
      'ownerEmailAddress': ownerEmailAddress,
      'isOwner': isOwner,
      'isRegistered': isRegistered,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      courtName: json['courtName'] ?? '',
      courtPhoneNumber: json['courtPhoneNumber'] ?? '',
      courtEmailAddress: json['courtEmailAddress'] ?? '',
      courtDescription: json['courtDescription'] ?? '',
      openingTime: json['openingTime'] ?? '',
      closingTime: json['closingTime'] ?? '',
      courtLocation: json['courtLocation'] ?? '',
      images: json['images'] ?? '',
      ownerPhoto: json['ownerPhoto'] ?? '',
      ownerFullName: json['ownerFullName'] ?? '',
      ownerPhoneNumber: json['ownerPhoneNumber'] ?? '',
      ownerEmailAddress: json['ownerEmailAddress'] ?? '',
      isOwner: json['isOwner'] ?? false,
      isRegistered: json['isRegistered'] ?? false,
    );
  }

  String get formattedOwnerPhoneNumber =>
      Formatter.formatPhoneNumber(ownerPhoneNumber);

  static List<String> splitFullName(String fullName) => fullName.split(' ');
}
