import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:system_tareo/models/trabajo_x_maquina.dart';

class ProgramaMaquinaProvider with ChangeNotifier {
  List<TrabajoMaquina> _progMaquinadata = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<TrabajoMaquina> get progMaquinadata => _progMaquinadata;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> obtenerProgramaMaquina({required String? idMaquina}) async {
    final link =
        'http://190.107.181.163:81/amq/t_prog_x_maquina.php?maquina=$idMaquina';

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    print('Solicitando: $link');

    try {
      final response = await http.get(Uri.parse(link));
      print('Estado HTTP: ${response.statusCode}');
      print('Respuesta cruda: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print('Respuesta decodificada: $responseBody');

        if (responseBody is List) {
          _progMaquinadata =
              responseBody.map((maq) => TrabajoMaquina.fromJson(maq)).toList();
          _errorMessage = null;
          print('Datos cargados: ${_progMaquinadata.length} registros');
          if (_progMaquinadata.isNotEmpty) {
            print('Primer registro: ${_progMaquinadata[0].toJson()}');
          }
        } else if (responseBody is Map<String, dynamic>) {
          if (responseBody.containsKey('error')) {
            _progMaquinadata = [];
            _errorMessage = responseBody['error'] as String? ?? 'Error desconocido';
            print('Mensaje de error: $_errorMessage');
          } else {
            throw Exception('Formato de respuesta inesperado: $responseBody');
          }
        } else {
          throw Exception('Formato de respuesta inválido: $responseBody');
        }
        notifyListeners();
      } else {
        throw Exception('No se pudo obtener el programa por máquina: ${response.statusCode}');
      }
    } catch (e) {
      _progMaquinadata = [];
      _errorMessage = 'No se pudieron obtener datos, error: $e';
      print('Excepción: $e');
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}