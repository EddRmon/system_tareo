import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:system_tareo/models/event_m_model.dart';

class EventMProvider with ChangeNotifier{
  List<EventM> _eventsGen = [];
  List<EventM> _filtroEventos = []; 
  bool _isLoading = false;
  
  List<EventM> get eventsGen => _filtroEventos;
  bool get isLoading => _isLoading;

  Future<void> eventMProvider() async{
    _isLoading = true;
    notifyListeners();
    const url = "http://192.168.3.20/tareo/tareo_event_m.php";
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final dataEventM = jsonDecode(response.body);
        if(dataEventM is List){
          _eventsGen = dataEventM.map((eventM) => EventM.fromJson(eventM)).toList();
          _filtroEventos = _eventsGen;
        } else if(dataEventM is Map<String, dynamic> && dataEventM.containsKey('error')){
          _eventsGen = (dataEventM['error'] as List).map((eventError) => EventM.fromJson(eventError)).toList();
          _filtroEventos = [];
        } else {
          throw Exception('Formato de Json no esperado: ${response.body}');
        }
      } else {
        throw Exception('Error al obtener datos de los eventos ${response.statusCode}');
      }
    } catch(e){
      _eventsGen = [];
      throw Exception('Error al obtener datos del servidor: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }

  }

  void buscarEventos(String nombEvent){
    if(nombEvent.isEmpty){
     _filtroEventos  = _eventsGen;
    } else {
      _filtroEventos = _eventsGen.where((event){
        return event.description.toLowerCase().contains(nombEvent.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
  


}