import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:system_tareo/models/resgistro_model.dart';

class MostrarRegistrosProvider with ChangeNotifier {
  List<Registro> _registros = [];
  bool _isLoading = false;
  String? _errorMessage; // Para almacenar el mensaje de error si no hay datos

  List<Registro> get registros => _registros;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> obtenerRegistros({
    required String fecha,
    required String idusuario,
  }) async {
    final url =
        'http://192.168.3.20/tareo/registro_trabajo.php?fecha=$fecha&idusuario=$idusuario';
    _isLoading = true;
    _errorMessage = null; // Reseteamos el error
    notifyListeners();
    print('fecha $fecha y usuario $idusuario');
    try {
      final response = await http.get(Uri.parse(url));
      print('Respuesta de la api: $response');
      if (response.statusCode == 200) {
        final dynamic respuestaApi = jsonDecode(response.body);
        print('Respuesta de la api: $respuestaApi');
        print('Respuesta de la api: ${response.statusCode }');
        if (respuestaApi is List) {
          // Caso 1: Lista de registros
          _registros = respuestaApi.map((reg) => Registro.fromJson(reg)).toList();
          _errorMessage = null;
          print('Respuesta de la api: $respuestaApi');
        } else if (respuestaApi is Map<String, dynamic>) {
          // Caso 2: Objeto con error
          if (respuestaApi.containsKey('error')) {
            _registros = [];
            _errorMessage = respuestaApi['error'] as String? ?? 'Error desconocido';
          } else {
            throw Exception('Formato de respuesta inesperado: $respuestaApi');
          }
        } else {
          throw Exception('Formato de respuesta inválido: $respuestaApi');
        }
        notifyListeners();
      } else {
        throw Exception(
            'Error desde MostrarRegistrosProvider al obtener los datos del API: ${response.statusCode}');
      }
    } catch (e) {
      _registros = [];
      _errorMessage = 'Error al obtener datos del servidor: $e';
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  }