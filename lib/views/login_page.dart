import 'package:flutter/material.dart';
import 'package:system_tareo/widgets/sing_in.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: SingIn()),
    );
  }
}
