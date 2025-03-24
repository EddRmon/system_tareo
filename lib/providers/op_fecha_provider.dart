import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:system_tareo/models/op_fecha_model.dart';
import 'package:http/http.dart' as http;

class OpFechaProvider with ChangeNotifier{
  List<OpFecha> _opFechas = [];
  bool _isLoading = false;

  List<OpFecha> get opFechas => _opFechas;
  bool get isLoading => _isLoading;

  Future<void> obtenerfechasOp(String op) async {
    final String url = "http://192.168.3.20/tareo/tareo_fecha.php?numOp=$op"; 
    _isLoading = true;
    notifyListeners();
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final dataFecha = jsonDecode(response.body);
        if(dataFecha is List){
           _opFechas = dataFecha.map((e) => OpFecha.fromJson(e)).toList();
        } else if(dataFecha is Map<String, dynamic> && dataFecha.containsKey('error')){
          _opFechas = [];
        } else {
          throw Exception('Formato de Json no esperado: ${response.body}');
        }

      } else {
        throw Exception('Error al obtener datos de las fechas');
      }
    }catch(e) {
      _opFechas = [];
      throw Exception('Error al obtener datos del servidor: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  } 

}