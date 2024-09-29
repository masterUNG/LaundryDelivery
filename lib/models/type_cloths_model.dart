import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TypeClothsModel {
  final String id;
  final String typeCloths;
  final String price;
  final int? amount;

  TypeClothsModel({
    required this.id,
    required this.typeCloths,
    required this.price,
    this.amount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'typeCloths': typeCloths,
      'price': price,
      'amount': amount,
    };
  }

  factory TypeClothsModel.fromMap(Map<String, dynamic> map) {
    return TypeClothsModel(
      id: (map['id'] ?? '') as String,
      typeCloths: (map['typeCloths'] ?? '') as String,
      price: (map['price'] ?? '') as String,
      amount: (map['amount'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeClothsModel.fromJson(String source) =>
      TypeClothsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
