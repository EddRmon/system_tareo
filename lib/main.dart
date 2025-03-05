import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_tareo/app/app.dart';
import 'package:system_tareo/providers/prendiente.dart';


void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=> ProcesoProvider())
  ],
  child: const MyApp()));
}



