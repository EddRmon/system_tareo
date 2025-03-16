import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:system_tareo/models/op_prog.dart';

class OpProgramProvider with ChangeNotifier {
  List<OpProg> _listaOps = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<OpProg> get listaOps => _listaOps;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> obtenerOps(String opnum, String idmaqi) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final link = "http://190.107.181.163:81/amq/sys_tareo_prog.php?numop=$opnum&idmaq=$idmaqi"; //"http://192.168.3.20/tareo/tareo_trab_op_program.php?numop=$opnum&idmaq=$idmaqi";
    try {
      final response = await http.get(Uri.parse(link));

      if (response.statusCode == 200) {
        // Imprimir la respuesta para depuración
        print('Respuesta del servidor: ${response.body}');

        // Decodificar el JSON
        final jsonData = jsonDecode(response.body);

        // Verificar si jsonData es una lista
        if (jsonData is List) {
          // Si es una lista, mapear directamente a OpProg
          _listaOps = jsonData.map((op) => OpProg.fromJson(op)).toList();
        } else if (jsonData is Map<String, dynamic> && jsonData.containsKey('error')) {
          // Si es un mapa con una clave 'data', usar esa lista
          _listaOps = (jsonData['error'] as List).map((op) => OpProg.fromJson(op)).toList();
        } else {
          throw Exception('Formato de JSON no esperado: ${response.body}');
        }
      } else {
        throw Exception('Error al obtener los datos de op: ${response.statusCode}');
      }
    } catch (e) {
      _listaOps = [];
      _errorMessage = 'Error al obtener datos del servidor: $e';
      print('Error ---->> $e');
      // No lanzamos la excepción para que el Consumer pueda manejar el errorMessage
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}