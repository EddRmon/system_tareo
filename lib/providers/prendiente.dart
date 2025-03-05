import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProcesoProvider extends ChangeNotifier {
  bool _procesoPendiente = false;

  bool get procesoPendiente => _procesoPendiente;

  ProcesoProvider() {
    _cargarEstado();
  }

  Future<void> _cargarEstado() async {
    final prefs = await SharedPreferences.getInstance();
    _procesoPendiente = prefs.getBool('procesoPendiente') ?? false;
    notifyListeners();
  }

  Future<void> cambiarEstado() async {
    final prefs = await SharedPreferences.getInstance();
    _procesoPendiente = !_procesoPendiente;
    await prefs.setBool('procesoPendiente', _procesoPendiente);
    notifyListeners(); // 🔥 Notifica a la UI que cambió el estado
  }
}
