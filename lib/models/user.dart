import 'dart:convert';

class User {
  final int id;
  final int usuario;

  User({required this.id, required this.usuario});

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? 0,
      usuario: json["usuario"] ?? 0,
    );
  }
}
