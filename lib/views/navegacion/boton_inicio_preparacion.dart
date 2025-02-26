import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_tareo/views/unidades_procesadas.dart';

class BotonInicioPreparacion extends StatefulWidget {
  const BotonInicioPreparacion({super.key, required this.texto, this.initialIsProducing = false});
  final String texto;
  final bool initialIsProducing; // Parámetro opcional para inicializar isProducing

  @override
  State<BotonInicioPreparacion> createState() => _BotonInicioPreparacionState();
}

class _BotonInicioPreparacionState extends State<BotonInicioPreparacion> {
  bool isProducing = false; // Estado para controlar si está produciendo o no
  Stream<String> getHoraStream() {
    return Stream.periodic(const Duration(seconds: 1), (_) {
      return DateFormat('hh:mm:ss a').format(DateTime.now());
    });
  }

  @override
  void initState() {
    super.initState();
    _loadState(); // Cargar el estado persistente al iniciar
    // Si initialIsProducing es true, forzamos isProducing a true
    if (widget.initialIsProducing) {
      setState(() {
        isProducing = true;
      });
      _saveState(); // Guardar el estado inicial como true
    }
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
      print('Error al cargar el estado de BotonInicioPreparacion: $e');
      // Si ocurre un error, mantenemos el valor predeterminado (false)
    }
  }

  // Método para guardar el estado en SharedPreferences con manejo de errores
  Future<void> _saveState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isProducingEvento', isProducing); // Usamos una clave diferente
    } catch (e) {
      print('Error al guardar el estado de BotonInicioPreparacion: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (isProducing) {
          return false; // Bloquea la navegación hacia atrás si está en modo "FINALIZAR"
        }
        isProducing = false; // Resetear a false si se sale en modo "INICIAR"
        _saveState(); // Guardar el cambio a false
        return true;
      },
      child: Scaffold(
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
              // Botón dinámico (FINALIZAR, ya que siempre inicia en rojo si viene de PreparacionScreen)
              Center(
                child: ElevatedButton(
                  onPressed: isProducing
                      ? () {
                          // Mostrar el ModalBottomSheet con UnidadesProcesadas cuando se presiona "FINALIZAR"
                          _showUnidadesProcesadasDialog(
                            context,
                            () {
                              // Callback para resetear el estado cuando se presiona "FINALIZAR" en el diálogo
                              setState(() {
                                isProducing = false; // Volver a verde (aunque no lo usaremos aquí, por diseño)
                              });
                              _saveState(); // Guardar el cambio a false
                            },
                          );
                        }
                      : null, // Deshabilitar el botón si no está produciendo (aunque no debería ocurrir en este flujo)
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Siempre rojo al iniciar desde PreparacionScreen
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    'FINALIZAR ${widget.texto}',
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 60,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                ),
                child: Center(
                  child: StreamBuilder<String>(
                    stream: getHoraStream(),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.data ?? '',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para mostrar el ModalBottomSheet con el contenido de UnidadesProcesadas, pasando un callback
  void _showUnidadesProcesadasDialog(BuildContext context, VoidCallback onFinish) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
        final size = MediaQuery.of(context).size;
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: isLandscape ? size.height * 0.6 : size.height * 0.7,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text('Unidades Procesadas'),
                    SizedBox(
                      width: double.maxFinite,
                      child: UnidadesProcesadas(onFinish: onFinish, text: widget.texto),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Cierra el ModalBottomSheet
                      },
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}