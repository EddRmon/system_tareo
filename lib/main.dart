import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_tareo/app/app.dart';
import 'package:system_tareo/providers/auth_provider.dart';
import 'package:system_tareo/providers/machines_providers.dart';
import 'package:system_tareo/providers/prendiente.dart';


void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=> AuthProvider()),
    ChangeNotifierProvider(create: (_)=> ProcesoProvider()),
    ChangeNotifierProvider(create: (_)=> MachinesProviders()),

  ],
  child: const MyApp()));
}



