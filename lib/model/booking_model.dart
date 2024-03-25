

class BookingModel{
  String productName;
  String price;
  String qty;
  String buyerName;
  String buyerAddress;
  String buyerPhoneNumer;
  String buyerId;
  String paymentMethod;

  BookingModel({
    required this.productName,
    required this.price,
    required this.qty,
    required this.buyerName,
    required this.buyerAddress,
    required this.buyerPhoneNumer,
    required this.buyerId,
    required this.paymentMethod
});

  Map<String,dynamic>toMap(){
    return {
      "productName":this.productName,
      "price":this.price,
      "qty":this.qty,
      "buyerName":this.buyerName,
      "buyerAddress":this.buyerAddress,
      "buyerPhoneNumber":this.buyerPhoneNumer,
      "buyerId":this.buyerId,
      "paymentMethod":this.paymentMethod
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
      buyerId: Map["buyerId"]??"",
      paymentMethod: Map["paymentMethod"]??""
    );
  }
  BookingModel copyWith({
    String? productName,
    String? price,
    String? qty,
    String? buyerName,
    String? buyerAddress,
    String? buyerPhoneNumer,
    String? buyerId,
    String? paymentMethod


  }){
    return BookingModel(
        productName: productName ?? this.productName,
        price: price ?? this.price,
        qty: qty ?? this.qty,
        buyerName: buyerName ?? this.buyerName,
        buyerAddress: buyerAddress ?? this.buyerAddress,
        buyerPhoneNumer: buyerPhoneNumer ?? this.buyerPhoneNumer,
        buyerId: buyerId?? this.buyerId,
        paymentMethod: paymentMethod ?? this.paymentMethod
    );
  }
}