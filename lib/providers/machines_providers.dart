import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MachinesProviders with ChangeNotifier {
  List<Map<String, String>> _machines = [];
  List<Map<String, String>> get machines => _machines;
  

  Future<void> getMachines()async {
    const link = "http://192.168.3.20/tareo/maquinas_offset.php";
    try{
      final response = await http.get(Uri.parse(link));
      if(response.statusCode == 200){
        final List<dynamic> contentMaquinas = jsonDecode(response.body);
        print(machines);
        _machines = contentMaquinas.map((maq){
          final map = maq as Map<String,dynamic>;
          return {
            'MaqNro': map['MaqNro'].toString(),
            'MaqDes': map['MaqDes'].toString(),
          };
        }).toList();
        print('respuesta de la api -> $contentMaquinas');
        notifyListeners();
      } else {
        throw Exception("Error al obtener la respuesta de la api");
      }
    } catch(e){
      _machines = [];
      notifyListeners();
      // ignore: avoid_print
      print('Error tipo -> $e');
    }
  }



}