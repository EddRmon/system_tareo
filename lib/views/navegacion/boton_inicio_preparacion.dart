import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_tareo/views/unidades_procesadas.dart';

class BotonInicioPreparacion extends StatefulWidget {
  const BotonInicioPreparacion({super.key, required this.texto});
  final String texto;

  @override
  State<BotonInicioPreparacion> createState() => _BotonInicioPreparacionState();
}

class _BotonInicioPreparacionState extends State<BotonInicioPreparacion> {
  String? savedTime;

  Stream<String> getHoraStream() {
    return Stream.periodic(const Duration(seconds: 0), (_) {
      return DateFormat('hh:mm:ss a').format(DateTime.now());
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSavedTime(); // Cargar el tiempo guardado desde SharedPreferences
  }

  // Método para cargar el tiempo guardado desde SharedPreferences
  Future<void> _loadSavedTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final time = prefs.getString('savedTime');
      setState(() {
        savedTime = time;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error al cargar el tiempo guardado: $e');
      }
    }
  }

  String formatearFecha(String formatexto) {
    List<String> fechaSeparar = formatexto.split(' ');
    String anioMesDia = fechaSeparar[0];
    String horaMinSeg = fechaSeparar[1];

    List<String> dividirFecha = anioMesDia.split('-');
    String anio = dividirFecha[0];
    String mes = dividirFecha[1];
    String dia = dividirFecha[2];

    String fechaInvertida = '$dia-$mes-$anio $horaMinSeg';
    return fechaInvertida;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false; // Bloquea la navegación hacia atrás hasta que se cierre el ModalBottomSheet
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Inicio de ${widget.texto}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size.width > 600
                              ? 18
                              : 14, // Tamaño ajustado para responsividad
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        savedTime == null
                            ? 'No hay tiempo guardado.'
                            : ' ${formatearFecha(savedTime!)}',
                        style: TextStyle(
                          fontSize: size.width > 600
                              ? 16
                              : 14, // Tamaño ajustado para responsividad
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
              
                  SizedBox(height: size.height * 0.3),
              
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
                                "https://media.licdn.com/dms/image/v2/C4E03AQEdSK4YkDhv0w/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1658904251136?e=2147483647&v=beta&t=_O6mtTA6_7TPfhr8mpnBwJuYPze-590YZM9T4w8Hr6k"),
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
                  // Mostrar el tiempo guardado, si existe
              
                  const SizedBox(height: 20),
                  // Botón dinámico (FINALIZAR, rojo)
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _showUnidadesProcesadasDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        'FINALIZAR ${widget.texto}',
                        style: const TextStyle(fontSize: 14, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
                  height: 60,
                  width: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.amber
                            .withOpacity(0.9), // Gradiente ámbar más suave
                        Colors.amberAccent.withOpacity(0.7),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(12), // Bordes más suaves
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: StreamBuilder<String>(
                      stream: getHoraStream(),
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data ?? '',
                          style: TextStyle(
                            fontSize: size.width > 600
                                ? 18
                                : 16, // Tamaño ajustado para responsividad
                            fontWeight: FontWeight.bold,
                            color: Colors
                                .black87, // Color más legible en fondo ámbar
                          ),
                        );
                      },
                    ),
                  ),
                ),
      ),
    );
  }

  // Método para mostrar el ModalBottomSheet con el contenido de UnidadesProcesadas
  void _showUnidadesProcesadasDialog(BuildContext context) {
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
            height: isLandscape ? size.height * 0.6 : size.height * 0.5,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Minimiza la altura del Column
                  children: [
                    const Text('Unidades Procesadas'),
                    SizedBox(
                      width: double.maxFinite,
                      child: UnidadesProcesadas(
                          onFinish: () {
                            Navigator.of(context)
                                .pop(); 
                                Navigator.of(context)
                                .pop(); // Cierra el ModalBottomSheet al presionar "FINALIZAR"
                          },
                          text: widget.texto),
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
