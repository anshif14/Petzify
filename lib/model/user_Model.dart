class userModel {
  String? name;
  String? email;
  String? password;
  String? id;
  String? images;
  userModel({
    this.name,
    this.email,
    this.password,
    this.id,
    this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": this.name,
      "email": this.email,
      "password": this.password,
      "id": this.id,
      "images": this.images,
    };
  }

  factory userModel.fromMap(Map<String, dynamic> Map) {
    return userModel(
      name: Map["name"] ?? "",
      email: Map["email"] ?? "",
      password: Map["password"] ?? "",
      id: Map["id"] ?? "",
      images: Map["images"] ?? "",
    );
  }

  userModel copyWith({
    String? name,
    String? email,
    String? password,
    String? id,
    String? images,

  }) {
    return userModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      // google: google ?? this.google,
      id: id ?? this.id,
      images: images ?? this.images,
    );
  }
}
