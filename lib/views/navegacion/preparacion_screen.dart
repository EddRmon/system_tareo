import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:system_tareo/views/navegacion/boton_inicio_preparacion.dart';

class PreparacionScreen extends StatefulWidget {
  const PreparacionScreen({super.key});

  @override
  State<PreparacionScreen> createState() => _PreparacionScreenState();
}

class _PreparacionScreenState extends State<PreparacionScreen> {
  String? selectedPreparationOption; // Opción seleccionada de Preparación
  bool showPreparationOptions = true; // Siempre mostrar opciones en esta vista

  // Mapa para rastrear el estado de cada opción de preparación (iniciada o terminada)
  final Map<String, bool> preparationOptionStates = {
    'Puesta a Punto': false,
    'Mantenimiento': false,
    'Revisión Técnica': false,
    'Producción Especial': false,
  };

  // Lista de opciones para Preparación
  final List<Map<String, dynamic>> preparationOptions = [
    {'icon': Icons.check_box, 'text': 'Puesta a Punto', 'color': Colors.green},
    {'icon': Icons.settings, 'text': 'Mantenimiento', 'color': Colors.orange},
    {
      'icon': Icons.build,
      'text': 'Revisión Técnica',
      'color': const Color.fromARGB(255, 103, 35, 230)
    },
    {
      'icon': Icons.work,
      'text': 'Producción Especial',
      'color': const Color.fromARGB(255, 221, 77, 84)
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadState(); // Cargar el estado persistente al iniciar
  }

  void iniciarProceso() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('procesoPendiente', true);
}

  Future<void> _saveTimeAndState(String option) async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    
    // Guardar hora y estado pendiente específicos para esta opción
    await prefs.setString('savedTime_$option', formattedTime);
    await prefs.setBool('procesoPendiente_$option', true);
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
      // Si ocurre un error, mantenemos los valores predeterminados (false para todas las opciones)
    }
  }

  Future<void> _saveTime() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    await prefs.setString('savedTime', formattedTime);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // Fondo minimalista y claro
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 124, 179),
        elevation: 0, // Sin sombra para un look limpio
        title: const Text(
          'Preparación',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Volver a TiposEventos
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: size.width > 600 ? 3 : 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: size.width > 600
                    ? 1.2
                    : 1.0, // Ajuste responsivo para pantallas grandes/pequeñas
              ),
              itemCount: preparationOptions.length,
              itemBuilder: (context, index) {
                final option = preparationOptions[index];
                return _buildOptionButton(
                  context,
                  option['icon']!,
                  option['text']!,
                  option['color']!,
                  size,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, IconData icon, String text,
      Color color, Size size) {
    final isProcessing = preparationOptionStates[text] ?? false;
    final isActiveOption = preparationOptionStates.values
        .any((value) => value); // Verifica si hay alguna opción activa
    final isEnabled = !isActiveOption ||
        preparationOptionStates[text] ==
            true; // Habilitada solo si no hay opción activa o es la opción activa

    return InkWell(
      onTap: () {
        
        _saveTime();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BotonInicioPreparacion(
                      texto: text,
                    )));
      },
      borderRadius: BorderRadius.circular(12),
      child: Opacity(
        opacity:
            isEnabled ? 1.0 : 0.5, // Reducir opacidad si está deshabilitada
        child: Container(
          decoration: BoxDecoration(
            color: isProcessing ? Colors.red : color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: size.width > 600 ? 28 : 22, color: Colors.white),
              const SizedBox(height: 8),
              Text(
                isProcessing ? 'Terminar Proceso' : text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width > 600 ? 16 : 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
