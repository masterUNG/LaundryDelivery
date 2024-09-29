import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TypeSoftenerModel {
  final String id;
  final String typeSoftener;
  final String price;
  TypeSoftenerModel({
    required this.id,
    required this.typeSoftener,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'typeSoftener': typeSoftener,
      'price': price,
    };
  }

  factory TypeSoftenerModel.fromMap(Map<String, dynamic> map) {
    return TypeSoftenerModel(
      id: (map['id'] ?? '') as String,
      typeSoftener: (map['typeSoftener'] ?? '') as String,
      price: (map['price'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeSoftenerModel.fromJson(String source) => TypeSoftenerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
