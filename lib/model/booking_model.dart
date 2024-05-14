

class BookingModel{
  String productName;
  String productImage;
  String price;
  String qty;
  String buyerName;
  String state;
  String buyerhouseno;
  String buyerarea;
  String buyerlandmark;
  String pincode;
  String buyercity;
  String buyerPhoneNumer;
  String bookingId;
  String paymentMethod;
  String userId;
  String productId;
  int selectindex;
  List search;


  BookingModel({
    required this.productName,
    required this.productImage,
    required this.price,
    required this.qty,
    required this.buyerName,
    required this.state,
    required this.buyerhouseno,
    required this.buyerarea,
    required this.buyerlandmark,
    required this.pincode,
    required this.buyercity,
    required this.buyerPhoneNumer,
    required this.bookingId,
    required this.paymentMethod,
    required this.userId,
    required this.productId,
    required this.selectindex,
    required this.search

});

  Map<String,dynamic>toMap(){
    return {
      "productName":this.productName,
      "productImage":this.productImage,
      "price":this.price,
      "qty":this.qty,
      "buyerName":this.buyerName,
      "state":this.state,
      "buyerhouseno":this.buyerhouseno,
      "buyerarea":this.buyerarea,
      "buyerlandmark":this.buyerlandmark,
      "pincode":this.pincode,
      "buyercity":this.buyercity,
      "buyerPhoneNumber":this.buyerPhoneNumer,
      "bookingId":this.bookingId,
      "paymentMethod":this.paymentMethod,
      "userId":this.userId,
      "productId":this.productId,
      "selectindex":this.selectindex,
      "search":this.search
    };
  }
  factory BookingModel.fromMap(Map<String,dynamic>Map){
    return BookingModel(
      productName: Map["productName"] ?? "",
        productImage: Map["productImage"] ?? "",
      price: Map["price"]??"",
        // price: Map["price"].toDouble() ?? "",
      qty: Map["qty"]??"",
      buyerName: Map["buyerName"]??"",
      state: Map["state"]??"",
      buyerhouseno: Map["buyerhouseno"]??"",
      buyerarea: Map["buyerarea"]??"",
      buyerlandmark: Map["buyerlandmark"]??"",
      pincode: Map["pincode"]??"",
      buyercity: Map["buyercity"]??"",
      buyerPhoneNumer: Map["buyerPhoneNumber"]??"",
        bookingId: Map["bookingId"]??"",
      paymentMethod: Map["paymentMethod"]??"",
        userId: Map["userId"] ?? "",
      productId: Map["productId"] ?? "",
        selectindex: Map["selectindex"] ?? 0,
      search: Map["search"]??[]

    );
  }
  BookingModel copyWith({
    String? productName,
    String? productImage,
    String? price,
    String? qty,
    String? buyerName,
    String? state,
    String? buyerhouseno,
    String? buyerarea,
    String? buyerlandmark,
    String? pincode,
    String? buyercity,
    String? buyerPhoneNumer,
    String? bookingId,
    String? paymentMethod,
    String? userId,
    String? productId,
    int? selectindex,
    List? search

  }){
    return BookingModel(
        productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
        price: price ?? this.price,
        qty: qty ?? this.qty,
        buyerName: buyerName ?? this.buyerName,
        state: state ?? this.state,
        buyerhouseno:buyerhouseno ?? this.buyerhouseno ,
        buyerarea: buyerarea ?? this.buyerarea,
        buyerlandmark: buyerlandmark ?? this.buyerlandmark,
        pincode: pincode ?? this.pincode,
        buyercity: buyercity ?? this.buyercity,
        buyerPhoneNumer: buyerPhoneNumer ?? this.buyerPhoneNumer,
      bookingId: bookingId?? this.bookingId,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      selectindex: selectindex ?? this.selectindex,
      search: search?? this.search
    );
  }
}