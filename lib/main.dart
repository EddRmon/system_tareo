import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_tareo/app/app.dart';
import 'package:system_tareo/providers/actu_evento_fin_provider.dart';
import 'package:system_tareo/providers/auth_provider.dart';
import 'package:system_tareo/providers/event_m_provider.dart';
import 'package:system_tareo/providers/event_p_provider.dart';
import 'package:system_tareo/providers/insertar_inicio_evento_provider.dart';
import 'package:system_tareo/providers/machines_providers.dart';
import 'package:system_tareo/providers/mostrar_registros_provider.dart';
import 'package:system_tareo/providers/op_fecha_provider.dart';
import 'package:system_tareo/providers/op_program_provider.dart';
import 'package:system_tareo/providers/prendiente.dart';
import 'package:system_tareo/providers/programa_maquina_provider.dart';


void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=> AuthProvider()),
    ChangeNotifierProvider(create: (_)=> ProcesoProvider()),
    ChangeNotifierProvider(create: (_)=> MachinesProviders()), 
    ChangeNotifierProvider(create: (_)=> MostrarRegistrosProvider()), 
    ChangeNotifierProvider(create: (_)=>ProgramaMaquinaProvider()), 
    ChangeNotifierProvider(create: (_)=>OpProgramProvider()), 
    ChangeNotifierProvider(create: (_)=>EventPProvider()),  
    ChangeNotifierProvider(create: (_)=>EventMProvider()), 
    ChangeNotifierProvider(create: (_)=>InsertarEventoProvider()), 
    ChangeNotifierProvider(create: (_)=>ActuEventoFinProvider()),
    ChangeNotifierProvider(create: (_)=>OpFechaProvider())
  ],
  child: const MyApp()));
}



