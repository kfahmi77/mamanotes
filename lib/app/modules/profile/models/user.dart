class UserModel {
  UserModel({
    required this.email,
    required this.name,
    required this.userId,
    required this.uid,
  });

  final String email;
  final String name;
  final String userId;
  final String uid;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"] ?? "",
        name: json["name"] ?? "",
        userId: json["userId"] ?? "",
        uid: json["uid"] ?? "",
      );

  Map<String, dynamic> toJson() =>
      {"code": email, "name": name, "userId": userId, "uid": uid};
}
