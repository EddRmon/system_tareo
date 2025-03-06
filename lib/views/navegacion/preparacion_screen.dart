import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_tareo/views/navegacion/boton_inicio_preparacion.dart';

class PreparacionScreen extends StatefulWidget {
  const PreparacionScreen({super.key});

  @override
  State<PreparacionScreen> createState() => _PreparacionScreenState();
}

class _PreparacionScreenState extends State<PreparacionScreen> {
  final List<Map<String, dynamic>> preparationOptions = [
    {'icon': Icons.check_box, 'text': 'Puesta a Punto', 'color': Colors.green},
    {'icon': Icons.settings, 'text': 'Mantenimiento', 'color': Colors.orange},
    {'icon': Icons.build, 'text': 'Revisión Técnica', 'color': const Color.fromARGB(255, 103, 35, 230)},
    {'icon': Icons.work, 'text': 'Producción Especial', 'color': const Color.fromARGB(255, 221, 77, 84)},
  ];

  Future<void> _saveTimeAndColor(String option) async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    await prefs.setString('savedTime_$option', formattedTime);
    await prefs.setInt('circleColor', Colors.red.value); // Cambiar a rojo al iniciar
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 124, 179),
        elevation: 0,
        title: const Text('Preparación', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
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
                childAspectRatio: size.width > 600 ? 1.2 : 1.0,
              ),
              itemCount: preparationOptions.length,
              itemBuilder: (context, index) {
                final option = preparationOptions[index];
                return _buildOptionButton(context, option['icon']!, option['text']!, option['color']!, size);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, IconData icon, String text, Color color, Size size) {
    return InkWell(
      onTap: () {
        _saveTimeAndColor(text); // Guardar tiempo y cambiar color a rojo
        Navigator.push(context, MaterialPageRoute(builder: (context) => BotonInicioPreparacion(texto: text)));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: size.width > 600 ? 28 : 22, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: size.width > 600 ? 16 : 12, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}