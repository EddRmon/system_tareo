import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_tareo/providers/auth_provider.dart';
import 'package:system_tareo/providers/event_p_provider.dart';
import 'package:system_tareo/providers/insertar_inicio_evento_provider.dart';
import 'package:system_tareo/views/navegacion/boton_inicio_preparacion.dart';

class PreparacionScreen extends StatefulWidget {
  const PreparacionScreen(
      {super.key,
      required this.tipoProceso,
      required this.motCodOdt,
      required this.secuencyMachine,
      required this.motNroElem,
      required this.odtMaq,
      required this.complement,
      required this.generado});
  final String tipoProceso;
  final String motCodOdt;
  final String secuencyMachine;
  final String motNroElem;
  final String odtMaq;
  final String complement;
  final String generado;

  @override
  State<PreparacionScreen> createState() => _PreparacionScreenState();
}

class _PreparacionScreenState extends State<PreparacionScreen> {
  Color colorAmarillo = const Color(0xFFFFF5CC);
  Color colorAzulClaro = const Color.fromARGB(255, 118, 133, 216);

  Future<void> _saveTimeAndColor(String option) async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    await prefs.setString('savedTime_$option', formattedTime);
    await prefs.setInt(
        'circleColor', Colors.red.value); // Cambiar a rojo al iniciar
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EventPProvider>().obtenerEventosP();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAzulClaro,
        elevation: 0,
        title: const Text('Preparación',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context)),
      ),
      backgroundColor: colorAmarillo,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Consumer<EventPProvider>(
              builder: (context, eventProv, child) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: size.width > 600 ? 3 : 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: size.width > 600 ? 1.2 : 1.0,
                  ),
                  itemCount: eventProv.evenPrep.length,
                  itemBuilder: (context, index) {
                    final event = eventProv.evenPrep[index];
                    return _buildOptionButton(
                        context, event.description, event.codeEvent, size);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(
      BuildContext context, String text, String maq, Size size) {
    final idOperdor = context.watch<AuthProvider>().idOperadors;
  
    return InkWell(
      onTap: () async {
        
       showDialog(
        context: context,
         builder: (BuildContext context){
        return  Center(
                  child: LoadingAnimationWidget.threeRotatingDots(
                    color: const Color.fromARGB(255, 63, 80, 177),
                    size: 50
                  ),
                );
       });
        print(' ${widget.motCodOdt}');
        print(' ${widget.complement}');
        print(' ${widget.motNroElem}');
        print(' ${widget.secuencyMachine}');
        print(' ${widget.odtMaq}');
        print(' ${widget.generado}');
        print(' $idOperdor');
        print(' ${widget.tipoProceso}');
        print(' $maq');
        try{
          await context.read<InsertarEventoProvider>().insertarEvento(
            nrop: widget.motCodOdt,
            complemento: widget.complement,
            elemento: widget.motNroElem,
            secuencia: widget.secuencyMachine,
            idmaquina: widget.odtMaq,
            estadog: widget.generado,
            idoperador: idOperdor,
            tipoproceso: widget.tipoProceso,
            codeevento: maq);
        } catch(e){
          showDialog(
                // ignore: use_build_context_synchronously
                context: context,
                //barrierDismissible: false,
                builder: (BuildContext context) {
                  // ignore: avoid_print
                  print('Error: $e');
                  return AlertDialog(
                    content: Text('El error $e'),
                  );
                });
        }
        

        _saveTimeAndColor(text); // Guardar tiempo y cambiar color a rojo
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BotonInicioPreparacion(
                      nombEvento: text,
                      tipoProceso: widget.tipoProceso,
                      motCodOdt: widget.motCodOdt,
                      secuencyMachine: widget.secuencyMachine,
                      motNroElem: widget.motNroElem,
                      odtMaq: widget.odtMaq,
                      complement: widget.complement,
                    )));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: size.width > 600 ? 16 : 12,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
