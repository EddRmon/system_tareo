import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:system_tareo/views/eventos_general_screen.dart';
import 'package:system_tareo/views/navegacion/boton_inicio_produccion.dart';

class TiposEventos extends StatefulWidget {
  const TiposEventos({super.key});

  @override
  State<TiposEventos> createState() => _TiposEventosState();
}

class _TiposEventosState extends State<TiposEventos> {
  String? selectedPreparationOption; // Opción seleccionada de Preparación
  bool showPreparationOptions = false; // Estado para mostrar las opciones de Preparación
  bool showProductionContent = false; // Estado para mostrar el contenido de Producción

  // Mapa para rastrear el estado de cada opción de preparación (iniciada o terminada)
  final Map<String, bool> preparationOptionStates = {
    'Puesta a Punto': false,
    'Mantenimiento': false,
    'Revisión Técnica': false,
    'Producción Especial': false,
  };

  final List<Map<String, dynamic>> eventos = [
    {'nombre': 'Preparación', 'color': Colors.blue[300], 'preparacion': true},
    {'nombre': 'Producción', 'color': Colors.green[400], 'produccion': true},
    {'nombre': 'Eventos Generales', 'color': Colors.teal[300], 'navigate': true},
  ];

  // Lista de opciones para Preparación
  final List<Map<String, dynamic>> preparationOptions = [
    {'icon': Icons.check_box, 'text': 'Puesta a Punto', 'color': Colors.green},
    {'icon': Icons.settings, 'text': 'Mantenimiento', 'color': Colors.green},
    {'icon': Icons.build, 'text': 'Revisión Técnica', 'color': Colors.green},
    {'icon': Icons.work, 'text': 'Producción Especial', 'color': Colors.green},
  ];

  @override
  void initState() {
    super.initState();
    _loadState(); // Cargar el estado persistente al iniciar
  }

  // Método para cargar el estado desde SharedPreferences con manejo de errores
  Future<void> _loadState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final state = prefs.getString('preparationOptionStates');
      if (state != null) {
        final Map<String, dynamic> decodedState = Map<String, dynamic>.from(jsonDecode(state));
        setState(() {
          preparationOptionStates.clear();
          decodedState.forEach((key, value) {
            preparationOptionStates[key] = value as bool;
          });
        });
      }
    } catch (e) {
      print('Error al cargar el estado: $e');
      // Si ocurre un error, mantenemos los valores predeterminados (false para todas las opciones)
    }
  }

  // Método para guardar el estado en SharedPreferences con manejo de errores
  Future<void> _saveState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('preparationOptionStates', jsonEncode(preparationOptionStates));
    } catch (e) {
      print('Error al guardar el estado: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Título y mensaje de imágenes guardadas
              const SizedBox(height: 8),
              const Text(
                'Eventos',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Elementos de la lista
              ...eventos.map((evento) {
                if (evento['preparacion'] == true) {
                  return _buildListItem(
                    context,
                    evento['nombre'],
                    Colors.blue[300]!,
                    () {
                      setState(() {
                        showPreparationOptions = true;
                        showProductionContent = false;
                        selectedPreparationOption = null;
                      });
                    },
                  );
                } else if (evento['produccion'] == true) {
                  return _buildListItem(
                    context,
                    evento['nombre'],
                    Colors.green[400]!,
                    () {
                      setState(() {
                        showProductionContent = true;
                        showPreparationOptions = false;
                      });
                    },
                  );
                } else if (evento['navigate'] == true) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildListItem(
                        context,
                        evento['nombre'],
                        Colors.teal[300]!,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EventosGeneralScreen()),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      // Mostrar las opciones de Preparación, el contenido de Producción o la cuadrícula de bienvenida
                      _buildDynamicContent(),
                    ],
                  );
                }
                return const SizedBox.shrink();
              }),

              const SizedBox(height: 24),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, String title, Color color, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, IconData icon, String text, Color color, VoidCallback onTap) {
    final isProcessing = preparationOptionStates[text] ?? false; // Estado de la opción (iniciada o terminada)
    return InkWell(
      onTap: () {
        _showConfirmationDialog(context, text, isProcessing, () {
          setState(() {
            if (isProcessing) {
              // Si está procesando (rojo), volver al estado inicial (verde)
              preparationOptionStates[text] = false;
            } else {
              // Si no está procesando, iniciar el proceso (rojo)
              preparationOptionStates[text] = true;
            }
            _saveState(); // Guardar el estado después de cada cambio
          });
        });
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: isProcessing ? Colors.red : color, // Cambia a rojo si está procesando
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2)),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: Colors.white),
            const SizedBox(height: 5),
            Text(
              isProcessing ? 'Terminar Proceso' : text, // Cambia el texto si está procesando
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // Método para mostrar el AlertDialog de confirmación
  void _showConfirmationDialog(BuildContext context, String option, bool isProcessing, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar Acción'),
          content: Text(
            isProcessing
                ? '¿Estás seguro de terminar el proceso para "$option"?'
                : '¿Estás seguro de iniciar el proceso para "$option"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cancelar
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Confirmar
                onConfirm(); // Llama al callback para cambiar el estado
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDynamicContent() {
    if (showPreparationOptions) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.2,
        ),
        itemCount: preparationOptions.length,
        itemBuilder: (context, index) {
          final option = preparationOptions[index];
          return _buildOptionButton(
            context,
            option['icon']!,
            option['text']!,
            option['color']!,
            () {
              // No es necesario aquí, ya que el onTap está en _buildOptionButton
            },
          );
        },
      );
    } else if (showProductionContent) {
      return const InicioProduccion(texto: 'Producción');
    } else {
      return const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.event_note, // Ícono genérico para eventos
            size: 60,
            color: Colors.blueGrey,
          ),
          SizedBox(height: 16),
          Text(
            'Eventos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'Comenzar: Preparación y Producción.',
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 117, 117, 117),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }
}