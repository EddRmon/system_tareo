// lib/viewmodels/event_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:system_tareo/models/event_model.dart';

class EventViewModel extends ChangeNotifier {
  
  final List<EventModel> _events = [
    EventModel(
      text: "INASISTENCIA PERSONAL",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    // Agrega aquí el resto de los eventos desde tu lista original
    EventModel(
      text: "LAVADO DE BATERIA",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "LIMPIEZA DE MANTILLA",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "LIMPIEZA DE MAQUINA",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "MANTENIMIENTO CORRECTIVO",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "MANTENIMIENTO INTEGRAL",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "MANTENIMIENTO OPERACIONAL",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "MANTENIMIENTO PREVENTIVO",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "MAQUINA INOPERATIVA",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "PASE ADICIONAL",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "PATRON DE COLOR",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "PERFILACION DE MAQUINA",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "AJUSTE DE IMPRESIÓN",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "AJUSTE DE PRESION",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "APOYO A OTRA AREA",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "CALADO DE BARNIZ",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "CAMBIO DE CITO",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "CAMBIO DE CUCHILLA",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "CAMBIO DE MANTILLA O PLACA",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "CAMBIO DE PROGRAMACION - PCP",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "CAPACITACION - REUNION",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "CORRECCIÓN DE CURVA",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "CORRECCIÓN DE TROQUEL",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "DEFECTO DEL MATERIAL",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "SIN CARGA",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "SIN CARGA CONPENSA FERIADO",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "SIN CARGA DOMINGO",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "SIN CARGA FERIADO",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "SIN CARGA POR FALTA DE MATERIA PRIMA",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "TRASLADO DE MAQUINA",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
    EventModel(
      text: "Z5",
      gradient: const [Color(0xFFFFF5CC), Color(0xFFFFF5CC)],
    ),
  ];
  List<EventModel> _filteredEvents = [];

  EventViewModel() {
    _filteredEvents = _events; // Inicialmente, muestra todos los eventos
  }

  void searchEvents(String query) {
    if (query.isEmpty) {
      _filteredEvents = _events;
    } else {
      _filteredEvents = _events
          .where((event) => event.text.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  List<EventModel> get events => _filteredEvents;
}