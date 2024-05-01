class ProductModel{
  String productname;
  List image;
  String description;
  String category;
  String petcategory;
  double price;
  String sellername;
  String address;
  String phonenumber;
  String id;
  String userid;
  List favUser;
  List review;
  List search;


  ProductModel({

    required this.productname,
    required this.image,
    required this.description,
    required this.category,
    required this.petcategory,
    required this.price,
    required this.sellername,
    required this.address,
    required this.phonenumber,
    required this.id,
    required this.userid,
    required this.favUser,
    required this.review,
    required this.search

});

  Map<String,dynamic> toMap(){
    return {
      "productname": this.productname,
      "image": this.image,
      "description": this.description,
      "category": this.category,
      "petcategory": this.petcategory,
      "price": this.price,
      "sellername":this.sellername,
      "address": this.address,
      "phonenumber": this.phonenumber,
      "id": this.id,
      "userid":this.userid,
      "favUser":this.favUser,
      "review":this.review,
      "search":this.search
    };
  }

  factory ProductModel.fromMap(Map<String,dynamic>Map){
    return ProductModel(
      productname: Map["productname"] ?? "",
      image: Map["image"] ?? [],
      description: Map["description"] ?? "",
      category: Map["category"] ?? "",
      petcategory: Map["petcategory"] ?? "",
      price: Map["price"] ?? "",
      sellername: Map["sellername"] ?? "",
      address: Map["address"] ?? "",
      phonenumber: Map["phonenumber"] ?? "",
      id: Map["id"]?? "",
      userid: Map["userid"]??"",
      favUser: Map["favUser"]??[],
        review:Map["review"]??[],
      search: Map["seach"]??[]
    );
  }

  ProductModel copyWith({
    String? productname,
    List? image,
    String? description,
    String? category,
    String? petcategory,
    double? price,
    String? sellername,
    String? address,
    String? phonenumber,
    String? id,
    String? userid,
    List? favUser,
    List? review,
    List? search
}){
    return ProductModel(
      productname: productname ?? this.productname,
      image: image ?? this.image,
      description: description ?? this.description,
      category: category ?? this.category,
      petcategory: petcategory ?? this.petcategory,
      price: price ?? this.price,
      sellername: sellername ?? this.sellername,
      address: address ?? this.address,
      phonenumber: phonenumber ?? this.phonenumber,
      id: id ?? this.id,
      userid: userid ?? this.userid,
      favUser: favUser??this.favUser,
        review: review??this.review,
      search: search??this.search
    );
  }

}
