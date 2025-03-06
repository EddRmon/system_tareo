import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  // ignore: prefer_final_fields
  bool _isLoading = false;
  String _user = '';
  String _nombreOperador = '';
  

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String get user => _user;
  String get nombreOperador => _nombreOperador;

Future<void> authentication(String usuario, String contra)async {
  try{
    await login(usuario, contra);
  }catch(e){
    print("Error desde void authentication-> $e");
  }
}

Future<void> login(String uss, String pass) async{
  _isLoading = true;
  notifyListeners();

  final  url = 'http://192.168.3.20/tareo/iniciar_sesion.php?uss=$uss&pass=$pass'; 
  try {
    print('datos por enviar uss $uss y pass $pass');
    final response = await http.get(Uri.parse(url),);
    if(response.statusCode == 200){
      print('estado -> ${response.statusCode}');
      final responseBody = jsonDecode(response.body);
      if(responseBody['valid'] == true){
        _user = responseBody['usuario'] ?? '';
        _nombreOperador = responseBody['operador'] ?? '';
        _isAuthenticated = true;
        print('Respuesta de la api-- $responseBody');
        notifyListeners();
      } else {
        _isAuthenticated = false;
        _user = '';
        _nombreOperador = '';
        notifyListeners();
        throw Exception(responseBody['message'] ?? 'Authentication failed');
      }
    } else{
      _isAuthenticated = false;
      _user = '';
      _nombreOperador = '';
      notifyListeners();
      throw Exception('Failed to Authentication');
    }
  } catch (e){
    _isAuthenticated = false;
    _user = '';
    print('Error desde AuthProvider--> $e');
    notifyListeners();
  }

  _isLoading = false;
  notifyListeners();

}

void logout(){
  _isAuthenticated = false;
  _user = '';
  _nombreOperador = '';
  notifyListeners();
}


}