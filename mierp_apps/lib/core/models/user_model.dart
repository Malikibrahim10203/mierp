class UserModel {
  String email;
  String firstName;
  String lastName;
  String role;

  UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "role": role,
  };
}
