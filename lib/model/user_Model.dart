class UserModel {
  String name;
  String email;
  String password;
  String id;
  String images;
  String number;
  String gender;
  List booking;
  List productadd;
  List favourites;
  bool block;
  int bookingCount;
  int productCount;

  UserModel({
    required this.name,
    required   this.email,
    required  this.password,
    required this.id,
    required  this.images,
    required this.number,
    required   this.gender,
    required   this.booking,
    required   this.productadd,
    required  this.favourites,
    required this.block,
    required this.bookingCount,
    required this.productCount,
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
      "productadd": this.productadd,
      "booking": this.booking,
      "favourites": this.favourites,
      "block":this.block,
      "bookingCount":this.bookingCount,
      "productCount":this.productCount,
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
      booking: Map["booking"] ?? [],
      productadd: Map["productadd"] ?? [],
      favourites: Map["favourites"] ?? "",
      block: Map["block"] ?? false,
      bookingCount: Map["bookingCount"] ?? 0,
      productCount: Map["productCount"] ?? 0,
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
    List? booking,
    List? productadd,
    List? favourites,
    bool? block,
    int? bookingCount,
    int? productCount,
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
      booking: booking ?? this.booking,
      productadd: productadd ?? this.productadd,
      favourites: favourites ?? this.favourites,
      block: block ?? this.block,
      bookingCount: bookingCount ?? this.bookingCount,
      productCount: productCount ?? this.productCount,
    );
  }
}
