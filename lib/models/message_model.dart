// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String customerId;
  final String message;
  final Timestamp timestamp;


  
  MessageModel({
    required this.customerId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customerId': customerId,
      'message': message,
      'timestamp': timestamp,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      customerId: (map['customerId'] ?? '') as String,
      message: (map['message'] ?? '') as String,
      timestamp: (map['timestamp'] ?? Timestamp(0, 0)),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
