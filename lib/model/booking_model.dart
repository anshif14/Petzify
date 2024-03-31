

class BookingModel{
  String productName;
  String productImage;
  String price;
  String qty;
  String buyerName;
  String buyerAddress;
  String buyerPhoneNumer;
  String buyerId;
  String paymentMethod;
  String userId;
  int selectindex;

  BookingModel({
    required this.productName,
    required this.productImage,
    required this.price,
    required this.qty,
    required this.buyerName,
    required this.buyerAddress,
    required this.buyerPhoneNumer,
    required this.buyerId,
    required this.paymentMethod,
    required this.userId,
    required this.selectindex
});

  Map<String,dynamic>toMap(){
    return {
      "productName":this.productName,
      "productImage":this.productImage,
      "price":this.price,
      "qty":this.qty,
      "buyerName":this.buyerName,
      "buyerAddress":this.buyerAddress,
      "buyerPhoneNumber":this.buyerPhoneNumer,
      "buyerId":this.buyerId,
      "paymentMethod":this.paymentMethod,
      "userId":this.userId,
      "selectindex":this.selectindex,
    };
  }
  factory BookingModel.fromMap(Map<String,dynamic>Map){
    return BookingModel(
      productName: Map["productName"] ?? "",
        productImage: Map["productImage"] ?? "",
      price: Map["price"]??"",
      qty: Map["qty"]??"",
      buyerName: Map["buyerName"]??"",
      buyerAddress: Map["buyerAddress"]??"",
      buyerPhoneNumer: Map["buyerPhoneNumber"]??"",
      buyerId: Map["buyerId"]??"",
      paymentMethod: Map["paymentMethod"]??"",
        userId: Map["userId"] ?? "",
        selectindex: Map["selectindex"] ?? -1
    );
  }
  BookingModel copyWith({
    String? productName,
    String? productImage,
    String? price,
    String? qty,
    String? buyerName,
    String? buyerAddress,
    String? buyerPhoneNumer,
    String? buyerId,
    String? paymentMethod,
    String? userId,
    int? selectindex,

  }){
    return BookingModel(
        productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
        price: price ?? this.price,
        qty: qty ?? this.qty,
        buyerName: buyerName ?? this.buyerName,
        buyerAddress: buyerAddress ?? this.buyerAddress,
        buyerPhoneNumer: buyerPhoneNumer ?? this.buyerPhoneNumer,
        buyerId: buyerId?? this.buyerId,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        userId: userId ?? this.userId,
      selectindex: selectindex ?? this.selectindex,
    );
  }
}