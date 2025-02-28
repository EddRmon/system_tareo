import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_tareo/views/navegacion/reloj_digital.dart';
import 'package:system_tareo/views/unidades_procesadas.dart';

class BotonInicioPreparacion extends StatefulWidget {
  const BotonInicioPreparacion({super.key, required this.texto});
  final String texto;

  @override
  State<BotonInicioPreparacion> createState() => _BotonInicioPreparacionState();
}

class _BotonInicioPreparacionState extends State<BotonInicioPreparacion> {
  String? savedTime;

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
        backgroundColor: const Color.fromARGB(255, 113, 153, 168),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Información del usuario
                  const Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Centrar el contenido horizontalmente
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                                "https://media.licdn.com/dms/image/v2/C4E03AQEdSK4YkDhv0w/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1658904251136?e=2147483647&v=beta&t=_O6mtTA6_7TPfhr8mpnBwJuYPze-590YZM9T4w8Hr6k"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Ricardo Monago",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Times New Roman'),
                            ),
                            Text(
                              "Turno: Mañana",
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'Times New Roman'),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Text(
                        savedTime == null
                            ? 'No hay tiempo guardado.'
                            : 'Hora de inicio ${widget.texto}\n ${formatearFecha(savedTime!)}',
                        style: TextStyle(
                            fontSize: size.width > 600
                                ? 16
                                : 14, // Tamaño ajustado para responsividad
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Times New Roman'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const DigitalClock(
                    size: Size(130, 80),
                  ),

                  SizedBox(height: size.height * 0.1),

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
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Times New Roman'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
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
                    const Text('Unidades Procesadas', style: TextStyle(fontFamily: 'Times New Roman'),),
                    SizedBox(
                      width: double.maxFinite,
                      child: UnidadesProcesadas(
                          onFinish: () {
                            Navigator.of(context).pop();
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
