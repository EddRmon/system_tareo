import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_tareo/views/navegacion/boton_inicio_eventogeneral.dart';

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
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0vdRu_xMttOt5RGpxWef8FOVE0qitVojSb1QGyyzri0iT_CYge8I11CwlRwZW4uiM_VM&usqp=CAU"),
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
                              "Turno: Noche",
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
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
