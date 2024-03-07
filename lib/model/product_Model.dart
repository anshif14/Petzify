class ProductModel{
  String productname;
  List image;
  String description;
  String? category;
  double price;
  String sellername;
  String address;
  String phonenumber;
  String id;


  ProductModel({

    required this.productname,
    required this.image,
    required this.description,
    this.category,
    required this.price,
    required this.sellername,
    required this.address,
    required this.phonenumber,
    required this.id

});

  Map<String,dynamic> toMap(){
    return {
      "productname": this.productname,
      "image": this.image,
      "description": this.description,
      "category": this.category,
      "price": this.price,
      "sellername":this.sellername,
      "address": this.address,
      "phonenumber": this.phonenumber,
      "id": this.id
    };
  }

  factory ProductModel.fromMap(Map<String,dynamic>Map){
    return ProductModel(
      productname: Map["productname"] ?? "",
      image: Map["image"] ?? [],
      description: Map["description"] ?? "",
      category: Map["category"] ?? "",
      price: Map["price"] ?? "",
      sellername: Map["sellername"] ?? "",
      address: Map["address"] ?? "",
      phonenumber: Map["phonenumber"] ?? "",
      id: Map["id"]?? ""
    );
  }

  ProductModel copyWith({
    String? productname,
    List? image,
    String? description,
    String? category,
    double? price,
    String? sellername,
    String? address,
    String? phonenumber,
    String? id
}){
    return ProductModel(
      productname: productname ?? this.productname,
      image: image ?? this.image,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      sellername: sellername ?? this.sellername,
      address: address ?? this.address,
      phonenumber: phonenumber ?? this.phonenumber,
      id: id ?? this.id
    );
  }

}
