import 'dart:js_util';

class BookingModel{
  String? productName;
  String? price;
  String? qty;
  String? buyerName;
  String? buyerAddress;
  String? buyerPhoneNumer;
  String? buyerId;

  BookingModel({
    this.productName,
    this.price,
    this.qty,
    this.buyerName,
    this.buyerAddress,
    this.buyerPhoneNumer,
    this.buyerId
});

  Map<String,dynamic>toMap(){
    return {
      "productName":this.productName,
      "price":this.price,
      "qty":this.buyerName,
      "buyerName":this.buyerPhoneNumer,
      "buyerAddress":this.buyerAddress,
      "buyerPhoneNumber":this.buyerPhoneNumer,
      "buyerId":this.buyerId,
    };
  }
  factory BookingModel.fromMap(Map<String,dynamic>Map){
    return BookingModel(
      productName: Map["productName"] ?? "",
      price: Map["price"]??"",
      qty: Map["qty"]??"",
      buyerName: Map["buyerName"]??"",
      buyerAddress: Map["buyerAddress"]??"",
      buyerPhoneNumer: Map["buyerPhoneNumber"]??"",
      buyerId: Map["buyerId"]??""
    );
  }
  BookingModel copyWith({
    String? productName,
    String? price,
    String? qty,
    String? buyerName,
    String? buyerAddress,
    String? buyerPhoneNumer,
    String? buyerId


  }){
    return BookingModel(
        productName: productName ?? this.productName,
        price: price ?? this.price,
        qty: qty ?? this.qty,
        buyerName: buyerName ?? this.buyerName,
        buyerAddress: buyerAddress ?? this.buyerAddress,
        buyerPhoneNumer: buyerPhoneNumer ?? this.buyerPhoneNumer,
        buyerId: buyerId?? this.buyerId
    );
  }
}