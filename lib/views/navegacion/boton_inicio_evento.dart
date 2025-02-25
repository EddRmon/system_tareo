import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_tareo/views/unidades_procesadas.dart';

class BotonInicioEvento extends StatefulWidget {
  const BotonInicioEvento({super.key, required this.texto});
  final String texto;

  @override
  State<BotonInicioEvento> createState() => _BotonInicioEventoState();
}

class _BotonInicioEventoState extends State<BotonInicioEvento> {
  bool isProducing = false; // Estado para controlar si está produciendo o no

  @override
  void initState() {
    super.initState();
    _loadState(); // Cargar el estado persistente al iniciar
  }

  // Método para cargar el estado desde SharedPreferences con manejo de errores
  Future<void> _loadState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final state = prefs.getBool('isProducingEvento') ?? false; // Usamos una clave diferente para evitar conflictos
      setState(() {
        isProducing = state;
      });
    } catch (e) {
      print('Error al cargar el estado de BotonInicioEvento: $e');
      // Si ocurre un error, mantenemos el valor predeterminado (false)
    }
  }

  // Método para guardar el estado en SharedPreferences con manejo de errores
  Future<void> _saveState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isProducingEvento', isProducing); // Usamos una clave diferente
    } catch (e) {
      print('Error al guardar el estado de BotonInicioEvento: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.35),
            // Información del usuario
            const Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centrar el contenido horizontalmente
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          "https://media.licdn.com/dms/image/v2/C4E03AQEdSK4YkDhv0w/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1658904251136?e=2147483647&v=beta&t=_O6mtTA6_7TPfhr8mpnBwJuYPze-590YZM9T4w8Hr6k"),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Ricardo Monago",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Turno: Mañana",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Botón dinámico (Iniciar/Finalizar)
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (isProducing) {
                      // Mostrar el AlertDialog con UnidadesProcesadas cuando se presiona "Finalizar"
                      _showUnidadesProcesadasDialog(
                        context,
                        () {
                          // Callback para resetear el estado cuando se presiona "INICIAR" en el diálogo
                          setState(() {
                            isProducing = false; // Volver a verde con el texto original
                          });
                          _saveState(); // Guardar el cambio a false
                        },
                      );
                    } else {
                      isProducing = true; // Cambiar a estado de producción (rojo con "FINALIZAR")
                      _saveState(); // Guardar el cambio a true
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isProducing ? Colors.red : Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  isProducing ? 'FINALIZAR' : widget.texto,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para mostrar el AlertDialog con el contenido de UnidadesProcesadas, pasando un callback
  void _showUnidadesProcesadasDialog(BuildContext context, VoidCallback onStart) {
    showDialog(
      context: context,
      barrierDismissible: false, // No permite cerrar el diálogo tocando fuera
      builder: (context) {
        return AlertDialog(
          title: const Text('Unidades Procesadas'),
          content: SizedBox(
            width: double.maxFinite,
            child: UnidadesProcesadas(onStart: onStart), // Pasamos el callback a UnidadesProcesadas
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}