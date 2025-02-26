import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_tareo/views/navegacion/boton_inicio_produccion.dart';

class BotonPadreProduccion extends StatefulWidget {
  const BotonPadreProduccion({super.key, required this.texto});
  final String texto;

  @override
  State<BotonPadreProduccion> createState() => _BotonPadreProduccionState();
}

class _BotonPadreProduccionState extends State<BotonPadreProduccion> {
  bool isProducing = false; 

 // Estado para controlar si está produciendo o no
  Stream<String> getHoraStream() {
    return Stream.periodic(const Duration(seconds: 1), (_) {
      return DateFormat('hh:mm:ss a').format(DateTime.now());
    });
  }

  @override
  void initState() {
    super.initState();
    _loadState(); // Cargar el estado persistente al iniciar
  }

  // Método para cargar el estado desde SharedPreferences con manejo de errores
  Future<void> _loadState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final state = prefs.getBool('isProducingEvento') ??
          false; // Usamos una clave diferente para evitar conflictos
      setState(() {
        isProducing = state;
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error al cargar el estado de BotonInicioEvento: $e');
      // Si ocurre un error, mantenemos el valor predeterminado (false)
    }
  }

  // Método para guardar el estado en SharedPreferences con manejo de errores
  Future<void> _saveState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(
          'isProducingEvento', isProducing); // Usamos una clave diferente
    } catch (e) {
      // ignore: avoid_print
      print('Error al guardar el estado de BotonInicioEvento: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (isProducing) {
          return false;
        }
        isProducing = false;
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
                mainAxisAlignment: MainAxisAlignment
                    .center, // Centrar el contenido horizontalmente
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            "https://vegaperu.vtexassets.com/arquivos/ids/164772/130064.jpg?v=638248566159570000"),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Ricardo Monago",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
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
                              isProducing =
                                  false; // Volver a verde con el texto original
                            });
                            _saveState(); // Guardar el cambio a false
                          },
                        );
                      } else {
                        isProducing =
                            true; // Cambiar a estado de producción (rojo con "FINALIZAR")
                        _saveState(); // Guardar el cambio a true
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isProducing ? Colors.red : Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    isProducing
                        ? 'FINALIZAR ${widget.texto}'
                        : 'INICIAR: ${widget.texto}',
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
                    shape: BoxShape.rectangle),
                child: Center(
                  child: StreamBuilder<String>(
                    stream: getHoraStream(),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.data ?? '',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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

  // Método para mostrar el AlertDialog con el contenido de UnidadesProcesadas, pasando un callback
  void _showUnidadesProcesadasDialog(
      BuildContext context, VoidCallback onStart) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        final isLandscape =
            MediaQuery.of(context).orientation == Orientation.landscape;
        final size = MediaQuery.of(context).size;
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
              child: BotonInicioProduccion( text: widget.texto, onStart: onStart,),),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cierra el diálogo
                  
                },
                child: const Text('Cerrar'),
              ),
                  ],
                ),
              ),
            ),

            /*title: const Text('Unidades Procesadas'),
            content: SizedBox(
              width: double.maxFinite,
              child: UnidadesProcesadas(onStart: onStart, text: widget.texto,), // Pasamos el callback a UnidadesProcesadas
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cierra el diálogo
                  
                },
                child: const Text('Cerrar'),
              ),
            ],*/
          ),
        );
      },
    );
  }
}
