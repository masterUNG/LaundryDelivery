import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderWashModel {
  final String id;
  final String refWash;
  final String customerId;
  final String dateStart;
  final String timeStar;
  final String dateEnd;
  final String timeEnd;
  final String dry;
  final String amountCloth;
  final String detergen;
  final String softener;
  final String total;
  final String status;
  final String idAdminReceive;
  final String idAdminOrder;
  final String idAdminFinish;
  final String urlSlip;



  OrderWashModel({
    required this.id,
    required this.refWash,
    required this.customerId,
    required this.dateStart,
    required this.timeStar,
    required this.dateEnd,
    required this.timeEnd,
    required this.dry,
    required this.amountCloth,
    required this.detergen,
    required this.softener,
    required this.total,
    required this.status,
    required this.idAdminReceive,
    required this.idAdminOrder,
    required this.idAdminFinish,
    required this.urlSlip,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'refWash': refWash,
      'customerId': customerId,
      'dateStart': dateStart,
      'timeStar': timeStar,
      'dateEnd': dateEnd,
      'timeEnd': timeEnd,
      'dry': dry,
      'amountCloth': amountCloth,
      'detergen': detergen,
      'softener': softener,
      'total': total,
      'status': status,
      'idAdminReceive': idAdminReceive,
      'idAdminOrder': idAdminOrder,
      'idAdminFinish': idAdminFinish,
      'urlSlip': urlSlip,
    };
  }

  factory OrderWashModel.fromMap(Map<String, dynamic> map) {
    return OrderWashModel(
      id: (map['id'] ?? '') as String,
      refWash: (map['refWash'] ?? '') as String,
      customerId: (map['customerId'] ?? '') as String,
      dateStart: (map['dateStart'] ?? '') as String,
      timeStar: (map['timeStar'] ?? '') as String,
      dateEnd: (map['dateEnd'] ?? '') as String,
      timeEnd: (map['timeEnd'] ?? '') as String,
      dry: (map['dry'] ?? '') as String,
      amountCloth: (map['amountCloth'] ?? '') as String,
      detergen: (map['detergen'] ?? '') as String,
      softener: (map['softener'] ?? '') as String,
      total: (map['total'] ?? '') as String,
      status: (map['status'] ?? '') as String,
      idAdminReceive: (map['idAdminReceive'] ?? '') as String,
      idAdminOrder: (map['idAdminOrder'] ?? '') as String,
      idAdminFinish: (map['idAdminFinish'] ?? '') as String,
      urlSlip: (map['urlSlip'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderWashModel.fromJson(String source) =>
      OrderWashModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
