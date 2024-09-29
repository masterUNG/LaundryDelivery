import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TypeDetergenModel {
  final String id;
  final String typeDetergen;
  final String price;
  TypeDetergenModel({
    required this.id,
    required this.typeDetergen,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'typeDetergen': typeDetergen,
      'price': price,
    };
  }

  factory TypeDetergenModel.fromMap(Map<String, dynamic> map) {
    return TypeDetergenModel(
      id: (map['id'] ?? '') as String,
      typeDetergen: (map['typeDetergen'] ?? '') as String,
      price: (map['price'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeDetergenModel.fromJson(String source) => TypeDetergenModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
