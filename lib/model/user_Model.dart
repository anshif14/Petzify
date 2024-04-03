class UserModel {
  String name;
  String email;
  String password;
  String id;
  String images;
  String number;
  String gender;
  String booking;
  String productadder;
  List favourites;
  bool block;
  UserModel({
    required this.name,
    required   this.email,
    required  this.password,
    required this.id,
    required  this.images,
    required this.number,
    required   this.gender,
    required   this.booking,
    required   this.productadder,
    required  this.favourites,
    required this.block,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": this.name,
      "email": this.email,
      "password": this.password,
      "id": this.id,
      "images": this.images,
      "number": this.number,
      "gender": this.gender,
      "productadder": this.productadder,
      "booking": this.booking,
      "favourites": this.favourites,
      "block":this.block
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> Map) {
    return UserModel(
      name: Map["name"] ?? "",
      email: Map["email"] ?? "",
      password: Map["password"] ?? "",
      id: Map["id"] ?? "",
      images: Map["images"] ?? "",
      number: Map["number"] ?? "",
      gender: Map["gender"] ?? "",
      booking: Map["booking"] ?? "",
      productadder: Map["productadder"] ?? "",
      favourites: Map["favourites"] ?? "",
      block: Map["block"] ?? false,
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? id,
    String? images,
    String? number,
    String? gender,
    String? booking,
    String? productadder,
    List? favourites,
    bool? block,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      // google: google ?? this.google,
      id: id ?? this.id,
      images: images ?? this.images,
      number: number ?? this.number,
      gender: gender ?? this.gender,
      booking: gender ?? this.booking,
      productadder: productadder ?? this.productadder,
      favourites: favourites ?? this.favourites,
      block: block ?? this.block,
    );
  }
}
