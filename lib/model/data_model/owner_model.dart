import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/portion/formater.dart';

class OwnerModel {
  String id;
  String courtName;
  String courtPhoneNumber;
  String courtEmailAddress;
  String courtDescription;
  TimeOfDay openingTime;
  TimeOfDay closingTime;
  String courtLocation;
  double price;
  List<String> images;
  String ownerPhoto;
  String ownerFullName;
  String ownerPhoneNumber;
  String ownerEmailAddress;
  bool is24h;
  bool isOwner;
  bool isRegistered;

  OwnerModel({
    required this.id,
    required this.courtName,
    required this.courtPhoneNumber,
    required this.courtEmailAddress,
    required this.courtDescription,
    required this.openingTime,
    required this.closingTime,
    required this.courtLocation,
    required this.price,
    required this.images,
    required this.ownerPhoto,
    required this.ownerFullName,
    required this.ownerPhoneNumber,
    required this.ownerEmailAddress,
    required this.is24h,
    required this.isOwner,
    required this.isRegistered,
  });

  /// Create an [OwnerModel] instance from a JSON map
  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    List<String> images = [];
    if (json['images'] != null && json['images'] is List) {
      images = List<String>.from(json['images']);
    }

    var openingTime = Formatter.timestampToTimeOfDay(json['openingTime']);
    var closingTime = Formatter.timestampToTimeOfDay(json['closingTime']);

    return OwnerModel(
      id: json['id'] ?? "N/A",
      courtName: json['courtName'] ?? "N/A",
      courtPhoneNumber: json['courtPhoneNumber'] ?? "N/A",
      courtEmailAddress: json['courtEmailAddress'] ?? "N/A",
      courtDescription: json['courtDescription'] ?? "N/A",
      openingTime: openingTime,
      closingTime: closingTime,
      courtLocation: json['courtLocation'] ?? "N/A",
      price: Formatter.firebaseNumberToDouble(json['price']),
      images: images,
      ownerPhoto: json['ownerPhoto'] ?? "N/A",
      ownerFullName: json['ownerFullName'] ?? "N/A",
      ownerPhoneNumber: json['ownerPhoneNumber'] ?? "N/A",
      ownerEmailAddress: json['ownerEmailAddress'] ?? "N/A",
      is24h: json['is24h'] ?? false,
      isOwner: json['isOwner'] ?? false,
      isRegistered: json['isRegistered'] ?? false,
    );
  }

  /// Create an empty [OwnerModel] instance
  factory OwnerModel.emptyOwnerModel() {
    return OwnerModel(
      id: '',
      courtName: '',
      courtPhoneNumber: '',
      courtEmailAddress: '',
      courtDescription: '',
      openingTime: TimeOfDay.now(),
      closingTime: TimeOfDay.now(),
      courtLocation: '',
      price: 0,
      images: [],
      ownerPhoto: '',
      ownerFullName: '',
      ownerPhoneNumber: '',
      ownerEmailAddress: '',
      is24h: false,
      isOwner: false,
      isRegistered: false,
    );
  }

  /// Create an [OwnerModel] instance from a Firestore document snapshot
  factory OwnerModel.fromSnapshot(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    List<String> images = [];
    if (data['images'] != null && data['images'] is List) {
      images = List<String>.from(data['images']);
    }

    var openingTime = Formatter.timestampToTimeOfDay(data['openingTime']);
    var closingTime = Formatter.timestampToTimeOfDay(data['closingTime']);

    return OwnerModel(
      id: data['id'] ?? "N/A",
      courtName: data['courtName'] ?? "N/A",
      courtPhoneNumber: data['courtPhoneNumber'] ?? "N/A",
      courtEmailAddress: data['courtEmailAddress'] ?? "N/A",
      courtDescription: data['courtDescription'] ?? "N/A",
      openingTime: openingTime,
      closingTime: closingTime,
      courtLocation: data['courtLocation'] ?? "N/A",
      price: Formatter.firebaseNumberToDouble(data['price']),
      images: images,
      ownerPhoto: data['ownerPhoto'] ?? "N/A",
      ownerFullName: data['ownerFullName'] ?? "N/A",
      ownerPhoneNumber: data['ownerPhoneNumber'] ?? "N/A",
      ownerEmailAddress: data['ownerEmailAddress'] ?? "N/A",
      is24h: data['is24h'] ?? false,
      isOwner: data['isOwner'] ?? false,
      isRegistered: data['isRegistered'] ?? false,
    );
  }

  /// Convert an [OwnerModel] instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courtName': courtName,
      'courtPhoneNumber': courtPhoneNumber,
      'courtEmailAddress': courtEmailAddress,
      'courtDescription': courtDescription,
      'openingTime': Formatter.timeOfDayToTimestamp(openingTime),
      'closingTime': Formatter.timeOfDayToTimestamp(closingTime),
      'courtLocation': courtLocation,
      'price': price,
      'images': images,
      'ownerPhoto': ownerPhoto,
      'ownerFullName': ownerFullName,
      'ownerPhoneNumber': ownerPhoneNumber,
      'ownerEmailAddress': ownerEmailAddress,
      'is24h': is24h,
      'isOwner': isOwner,
      'isRegistered': isRegistered,
    };
  }

  /// Convert an [OwnerModel] instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courtName': courtName,
      'courtPhoneNumber': courtPhoneNumber,
      'courtEmailAddress': courtEmailAddress,
      'courtDescription': courtDescription,
      'openingTime': Formatter.timeOfDayToTimestamp(openingTime),
      'closingTime': Formatter.timeOfDayToTimestamp(closingTime),
      'courtLocation': courtLocation,
      'price': price,
      'images': images,
      'ownerPhoto': ownerPhoto,
      'ownerFullName': ownerFullName,
      'ownerPhoneNumber': ownerPhoneNumber,
      'ownerEmailAddress': ownerEmailAddress,
      'is24h': is24h,
      'isOwner': isOwner,
      'isRegistered': isRegistered,
    };
  }

  String get formattedOwnerPhoneNumber =>
      Formatter.formatPhoneNumber(ownerPhoneNumber);

  List<String> splitFullName(String fullName) => fullName.split(' ');
}
