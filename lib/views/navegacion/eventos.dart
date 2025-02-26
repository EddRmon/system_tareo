import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:system_tareo/views/eventos_general_screen.dart';
import 'package:system_tareo/views/navegacion/boton_padre_produccion.dart';
import 'package:system_tareo/views/navegacion/preparacion_screen.dart';

class TiposEventos extends StatefulWidget {
  const TiposEventos({super.key});

  @override
  State<TiposEventos> createState() => _TiposEventosState();
}

class _TiposEventosState extends State<TiposEventos> {
  String? selectedPreparationOption; // Opción seleccionada de Preparación
  bool showPreparationOptions =
      false; // Estado para mostrar las opciones de Preparación
  bool showProductionContent =
      false; // Estado para mostrar el contenido de Producción
  int _currentPage = 0; // Variable para rastrear la página actual

  // Mapa para rastrear el estado de cada opción de preparación (iniciada o terminada)
  final Map<String, bool> preparationOptionStates = {
    'Puesta a Punto': false,
    'Mantenimiento': false,
    'Revisión Técnica': false,
    'Producción Especial': false,
  };

  final List<Map<String, dynamic>> eventos = [
    {
      'nombre': 'Preparación',
      'icon': Icons.build,
      'color': Colors.blue[300],
      'preparacion': true,
    },
    {
      'nombre': 'Producción',
      'icon': Icons.factory,
      'color': Colors.green[400],
      'produccion': true,
    },
    {
      'nombre': 'Eventos Generales',
      'icon': Icons.event,
      'color': Colors.teal[300],
      'navigate': true,
    },
  ];

  late PageController _pageController; // Controlador para el PageView
  @override
  void initState() {
    super.initState();
    _pageController = PageController(); // Inicializar el PageController
    _loadState(); // Cargar el estado persistente al iniciar
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Método para cargar el estado desde SharedPreferences con manejo de errores
  Future<void> _loadState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final state = prefs.getString('preparationOptionStates');
      if (state != null) {
        final Map<String, dynamic> decodedState =
            Map<String, dynamic>.from(jsonDecode(state));
        setState(() {
          preparationOptionStates.clear();
          decodedState.forEach((key, value) {
            preparationOptionStates[key] = value as bool;
          });
        });
      }
    } catch (e) {
      print('Error al cargar el estado: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eventos',
          style: TextStyle(
            fontSize: size.width > 600 ? 28 : 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          const SizedBox(
            height: 90,
          ),
          Expanded(
            child: GridView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size.width > 600 ? 3 : 1,
                  crossAxisSpacing: 12,
                  childAspectRatio: size.width > 600 ? 1.2 : 2.4,
                ),
                itemCount: eventos.length,
                itemBuilder: (context, index) {
                  final evento = eventos[index];
                  return _buildEventCard(evento, size, index == _currentPage,
                      () {
                    setState(() {
                      _currentPage = index; // Actualizar la página actual
                      if (evento['preparacion'] == true) {
                        ///////// ///////// ///////// ///////// ///////// Preparacion///////// ///////// ///////// ///////// ///////// ///////// 
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const PreparacionScreen(),
                                transitionDuration:
                                    const Duration(milliseconds: 350),
                                transitionsBuilder:
                                    (context, animation, secondary, child) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                            begin: const Offset(1.0, 0.0),
                                            end: Offset.zero)
                                        .animate(animation),
                                    child: child,
                                  );
                                }));
                      } else if (evento['produccion'] == true) {
                        ///////// ///////// ///////// ///////// ///////// Produccion///////// ///////// ///////// ///////// ///////// ///////// 
                        Navigator.push( 
                          context,
                          PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const BotonPadreProduccion(
                                        texto: 'produccion',
                                      ),
                              transitionDuration:
                                  const Duration(milliseconds: 350),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                          begin: const Offset(1.0, 0.0),
                                          end: Offset.zero)
                                      .animate(animation),
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                );
                              }),
                        );
                      } else if (evento['navigate'] == true) {
                        ///////// ///////// ///////// ///////// ///////// Eventyos Generales///////// ///////// ///////// ///////// ///////// ///////// 
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const EventosGeneralScreen(),
                              transitionDuration:
                                  const Duration(milliseconds: 350),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                          begin: const Offset(1.0, 0.0),
                                          end: Offset.zero)
                                      .animate(animation),
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                );
                              },
                            ));
                      }
                    });
                  });
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> evento, Size size,
      bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              evento['color'].withOpacity(isSelected ? 0.9 : 0.7),
              evento['color'].withOpacity(isSelected ? 1.0 : 0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              evento['icon'],
              color: Colors.white,
              size: size.width > 600 ? 24 : 28,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                evento['nombre'],
                style: TextStyle(
                  fontSize: size.width > 600 ? 16 : 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
              ),
            ),
            const SizedBox(width: 6),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
