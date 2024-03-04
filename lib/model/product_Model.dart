class ProductModel{
  String? productname;
  List? image;
  String? description;
  String? category;
  double? price;
  String? sellername;
  String? address;
  String? phonenumber;

  ProductModel({

    this.productname,
    this.image,
    this.description,
    this.category,
    this.price,
    this.sellername,
    this.address,
    this.phonenumber

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
      "phonenumber": this.phonenumber
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
    );
  }

}
