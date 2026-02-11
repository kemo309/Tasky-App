class UserModel {
  static String collection = "Users";
  UserModel({this.email, this.id, this.password, this.userName});
  UserModel.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'],
        email: json['email'],
        password: json['password'],
        userName: json['user_name'],
      );
  String? email;
  String? userName;
  String? password;
  String? id;

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "id": id,
      "password": password,
      "user_name": userName,
    };
  }
}
