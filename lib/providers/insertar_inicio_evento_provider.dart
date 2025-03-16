import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InsertarEventoProvider with ChangeNotifier{
  bool _isLoading = false;
  String? errorMessage;

  bool get isLoading => _isLoading;
  

  Future<void> insertarEvento({
    required String nrop,
    required String complemento,
    required String elemento,
    required String secuencia,
    required String idmaquina,
    required String estadog,
    required String idoperador,
    required String tipoproceso,
    required String codeevento,
  }) async {
    _isLoading = true;
    notifyListeners();
    const String link = "http://192.168.3.20/tareo/tareo_insert_event.php";
    try{
      final response = await http.post(Uri.parse(link),
        body: {
          'nrop':nrop,
          'complemento':complemento,
          'elemento':elemento,
          'secuencia':secuencia,
          'idmaquina':idmaquina,
          'estadog':estadog,
          'idoperador':idoperador,
          'tipoproceso':tipoproceso,
          'codeevento':codeevento,
        }
      );

      if(response.statusCode == 200){
        final respuestaApi = jsonDecode(response.body);
        if(respuestaApi['success'] == true){
          print("evento insertado correctamente");
        } else {
          errorMessage = respuestaApi['message'] ?? 'respuesta: -> $respuestaApi';
          print(errorMessage);
        }
      } else {
        errorMessage = "Error al insertar Datos: ${response.statusCode}";
        print(errorMessage);
      }

    }catch(e){
      errorMessage = "Error en la solicitud: $e";
      print(errorMessage);

    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}