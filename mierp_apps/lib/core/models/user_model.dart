class UserModel {
  String uid;
  String email;
  String firstName;
  String lastName;
  String role;

  UserModel({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json["uid"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "role": role,
  };
}
