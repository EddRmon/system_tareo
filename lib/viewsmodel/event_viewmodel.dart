// lib/viewmodels/event_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:system_tareo/models/event_model.dart';

class EventViewModel extends ChangeNotifier {
  final List<EventModel> _events = [
    EventModel(
      text: "INASISTENCIA PERSONAL",
      gradient: const [Colors.teal, Colors.green],
    ),
    // Agrega aquí el resto de los eventos desde tu lista original
    EventModel(
      text: "LAVADO DE BATERIA",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "LIMPIEZA DE MANTILLA",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "LIMPIEZA DE MAQUINA",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "MANTENIMIENTO CORRECTIVO",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "MANTENIMIENTO INTEGRAL",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "MANTENIMIENTO OPERACIONAL",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "MANTENIMIENTO PREVENTIVO",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "MAQUINA INOPERATIVA",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "PASE ADICIONAL",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "PATRON DE COLOR",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "PERFILACION DE MAQUINA",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "AJUSTE DE IMPRESIÓN",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "AJUSTE DE PRESION",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "APOYO A OTRA AREA",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "CALADO DE BARNIZ",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "CAMBIO DE CITO",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "CAMBIO DE CUCHILLA",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "CAMBIO DE MANTILLA O PLACA",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "CAMBIO DE PROGRAMACION - PCP",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "CAPACITACION - REUNION",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "CORRECCIÓN DE CURVA",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "CORRECCIÓN DE TROQUEL",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "DEFECTO DEL MATERIAL",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "SIN CARGA",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "SIN CARGA CONPENSA FERIADO",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "SIN CARGA DOMINGO",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "SIN CARGA FERIADO",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "SIN CARGA POR FALTA DE MATERIA PRIMA",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "TRASLADO DE MAQUINA",
      gradient: const [Colors.teal, Colors.green],
    ),
    EventModel(
      text: "Z5",
      gradient: const [Colors.teal, Colors.green],
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