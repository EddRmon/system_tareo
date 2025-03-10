import 'package:flutter/material.dart';
import 'package:system_tareo/widgets/sing_in.dart';




class MyApp extends StatelessWidget {

  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)),
      title: 'Login con Bloc',
      home: const SingIn(),
      /*
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/barraNavegacion' : (context) => const BarraNavegacion()
      },*/
      
    
    );
  }
}