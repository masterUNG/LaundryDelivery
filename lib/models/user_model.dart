import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {

  final String id;
  final String customerId;
  final String address;
  final String customerName;
  final String lastName;
  final String phoneNumber;
  final String lat;
  final String lng;
  final String status;
  final String email;
  final String password;
  UserModel({
    required this.id,
    required this.customerId,
    required this.address,
    required this.customerName,
    required this.lastName,
    required this.phoneNumber,
    required this.lat,
    required this.lng,
    required this.status,
    required this.email,
    required this.password,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'customerId': customerId,
      'address': address,
      'customerName': customerName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'lat': lat,
      'lng': lng,
      'status': status,
      'email': email,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: (map['id'] ?? '') as String,
      customerId: (map['customerId'] ?? '') as String,
      address: (map['address'] ?? '') as String,
      customerName: (map['customerName'] ?? '') as String,
      lastName: (map['lastName'] ?? '') as String,
      phoneNumber: (map['phoneNumber'] ?? '') as String,
      lat: (map['lat'] ?? '') as String,
      lng: (map['lng'] ?? '') as String,
      status: (map['status'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      password: (map['password'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
