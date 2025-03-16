import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ActuEventoFinProvider with ChangeNotifier {
  bool _isLoading = false;
  String? errorMessage;

  bool get isLoading => _isLoading;

  Future<void> actualizarEvento(
      {required String observsa,
      required String pliegosbuenos,
      required String pliegosmalos,
      required String op,
      required String codMaquina}) async {

    _isLoading = true;
    notifyListeners();

    const String url = "http://192.168.3.20/tareo/tareo_update_event.php";
    try {
      final response = await http.post(Uri.parse(url), body: {
        'observ': observsa,
        'pliegosParcial': pliegosbuenos,
        'plieghosParcMal': pliegosmalos,
        'op': op,
        'codMaquina': codMaquina
      });

      if(response.statusCode == 200){
        final respuestaUpdate= jsonDecode(response.body);
        if(respuestaUpdate['success'] == true){
          print("Evento actualizado correctamente");
        } else {
          errorMessage = respuestaUpdate["message"] ?? 'respuesta -> $respuestaUpdate';
          print(errorMessage); 
        }
      } else {
        errorMessage = "Error al actualizar el evento: ${response.statusCode}";
        print(errorMessage);
      }

    } catch (e) {
      errorMessage = "Error desde el servidor $e";
      print(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
