import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_tareo/blocs/auth_bloc.dart';
import 'package:system_tareo/repositories/auth_repository.dart';
import 'package:system_tareo/views/home_page.dart';
import 'package:system_tareo/views/login_page.dart';
import 'package:system_tareo/views/navegacion/barra_navegacion.dart';



class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  
  const MyApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository: authRepository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey)),
        title: 'Login con Bloc',
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
          '/barraNavegacion' : (context) => const BarraNavegacion()
        },
      ),
    );
  }
}