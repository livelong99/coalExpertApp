import 'package:coalexpert/Models/Ship.dart';

class Order {
  String UserId;
  String orderId;
  String transactionId;
  double amount;
  double quantity;
  Ship shipData ;
  int status;

  // Order.fromParams(String id, String Cname, String Email, String contact, String GST)
  //     : this.id = id,
  //       this.Cname = Cname,
  //       this.Email = Email,
  //       this.contact = contact,
  //       this.GST = GST,
  //       this.ProfilePic = "images";



  Order.fromJson(Map json)
      : UserId = json['UserId'],
        orderId = json['orderId'],
        transactionId = json['transactionId'],
        amount = json['amount'].toDouble(),
        quantity = json['quantity'].toDouble(),
        status = json['status'],
        shipData = Ship.fromJson(json['shipData']);


  Map toJson() {
    return {'UserId': UserId, 'orderId': orderId, 'transactionId': transactionId, 'amount': amount, 'quantity': quantity, 'status': status, 'shipData': shipData.toJson()};
  }
}