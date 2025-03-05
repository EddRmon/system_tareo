import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_tareo/views/navegacion/boton_inicio_eventogeneral.dart';
import 'package:system_tareo/views/navegacion/reloj_digital.dart';

class BotonPadreEventogeneral extends StatefulWidget {
  const BotonPadreEventogeneral({super.key, required this.texto});
  final String texto;

  @override
  State<BotonPadreEventogeneral> createState() =>
      _BotonPadreEventogeneralState();
}

class _BotonPadreEventogeneralState extends State<BotonPadreEventogeneral> {
  String? savedTime;

  // Estado para controlar si está produciendo o no
  Stream<String> getHoraStream() {
    return Stream.periodic(const Duration(seconds: 0), (_) {
      return DateFormat('hh:mm:ss a').format(DateTime.now());
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSavedTime(); // Cargar el estado persistente al iniciar
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
      print('Error al cargar el tiempo guardado: $e');
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
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 5, 124, 179),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height*0.15,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Información del usuario
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                    "https://media.licdn.com/dms/image/v2/C4E03AQEdSK4YkDhv0w/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1658904251136?e=2147483647&v=beta&t=_O6mtTA6_7TPfhr8mpnBwJuYPze-590YZM9T4w8Hr6k"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Nombre y turno
                          const Column(
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
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Reloj Digital debajo de la foto
                          const DigitalClock(size: Size(130, 80)),
                          const SizedBox(height: 20),
                          // Información de la hora guardada
                          Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              child: Text(
                                savedTime == null
                                    ? 'No hay tiempo guardado.'
                                    : 'Hora de inicio ${widget.texto}\n ${formatearFecha(savedTime!)}',
                                style: TextStyle(
                                  fontSize: size.width > 600 ? 16 : 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: 'Times New Roman',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              
                  const SizedBox(height: 20),
                  
                  
                
                  // Botón dinámico (Iniciar/Finalizar)
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _eventosGeneralesDialog(
                              context
                            );
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
                  
                  
                ],
              ),
            ),
          ),
        ),
        
      ),
    );
  }

  // Método para mostrar el AlertDialog con el contenido de UnidadesProcesadas, pasando un callback
  void _eventosGeneralesDialog(
      BuildContext context) {
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
                  mainAxisSize: MainAxisSize.min, // Minimiza la altura del Column
                  children: [
                    const Text('Unidades Procesadas'),
                    SizedBox(
                      width: double.maxFinite,
                      child: BotonInicioEventogeneral(
                       
                        text: widget.texto, onFinish: () { 
                          Navigator.of(context).pop(); 
                         },
                      ),
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
