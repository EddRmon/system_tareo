import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthRepository {
  final String baseUrl = "http://192.168.3.20/tareo/sing_in.php";

  Future<User?> login(int username, String password) async {
    print('Usuario: $username y contraseña: $password' );
    final response = await http.get(Uri.parse('$baseUrl?uss=$username&pass=$password'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['valid'] == true) {
        print(data);
        return User(id: int.tryParse(data['usuario'].toString()) ?? 0 , usuario: username);
        
      } else {
        throw Exception("Credenciales incorrectas");
      }
    } else {
      throw Exception("Error al conectar con el servidor");
    }
  }
}
