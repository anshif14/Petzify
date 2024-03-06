class userModel {
  String name;
  String email;
  String password;
  String id;
  String images;
  String number;
  String gender;
  List favourites;
  userModel({
    required this.name,
    required   this.email,
    required  this.password,
    required this.id,
    required  this.images,
    required this.number,
    required   this.gender,
  required  this.favourites,
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
      "favourites": this.favourites,
    };
  }

  factory userModel.fromMap(Map<String, dynamic> Map) {
    return userModel(
      name: Map["name"] ?? "",
      email: Map["email"] ?? "",
      password: Map["password"] ?? "",
      id: Map["id"] ?? "",
      images: Map["images"] ?? "",
      number: Map["number"] ?? "",
      gender: Map["gender"] ?? "",
      favourites: Map["favourites"] ?? "",
    );
  }

  userModel copyWith({
    String? name,
    String? email,
    String? password,
    String? id,
    String? images,
    String? number,
    String? gender,
    List? favourites,
  }) {
    return userModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      // google: google ?? this.google,
      id: id ?? this.id,
      images: images ?? this.images,
      number: number ?? this.number,
      gender: gender ?? this.gender,
      favourites: favourites ?? this.favourites,
    );
  }
}
