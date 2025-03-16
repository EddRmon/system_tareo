import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:system_tareo/models/event_p_model.dart';
import 'package:http/http.dart' as http;

class EventPProvider with ChangeNotifier{
  List<EventP> _evenPrep = [];
  bool _isLoading = false;

  List<EventP> get evenPrep => _evenPrep;
  bool get isLoading => _isLoading;

  Future<void> obtenerEventosP()async {
    _isLoading = false;
    notifyListeners();
    const link = "http://192.168.3.20/tareo/tareo_event_p.php";

    try{
      final response = await http.get(Uri.parse(link));
      if(response.statusCode == 200){
        final dataEvent = jsonDecode(response.body);
        if(dataEvent is List){
          _evenPrep = dataEvent.map((ev) => EventP.fromJson(ev)).toList();
        } else if(dataEvent is Map<String,dynamic> && dataEvent.containsKey('error')) {
          _evenPrep = (dataEvent['error'] as List).map((event) => EventP.fromJson(event)).toList();
        } else {
          throw Exception("Formato de JSON no esperado: ${response.body}");
        }
      } else {
        throw Exception('Error al obtener los datos de lo eventos ${response.statusCode}');
      }
    }  catch(e){
      _evenPrep = [];
      
      throw Exception('Error al obtener datos del servidor: $e');
      
    } finally {
      _isLoading = false;
      notifyListeners();
    }

  }

}