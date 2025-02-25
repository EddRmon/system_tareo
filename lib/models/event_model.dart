// lib/models/event_model.dart
import 'dart:ui';

class EventModel {
  final String text;
  final List<Color> gradient;

  EventModel({required this.text, required this.gradient});

  // Método para crear desde un Map (como los datos actuales)
  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      text: map['text'] as String,
      gradient: (map['gradient'] as List).map((color) => color as Color).toList(),
    );
  }
}