import 'package:flutter/material.dart';
import 'package:system_tareo/app/app.dart';
import 'package:system_tareo/repositories/auth_repository.dart';

void main() {
  final authRepository = AuthRepository();
  runApp( MyApp(authRepository: authRepository,));
}



