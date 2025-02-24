/*import 'package:flutter/material.dart';
import 'package:system_tareo/views/inicio_evento.dart';
import 'package:system_tareo/views/navegacion/boton_inicio_produccion.dart';

class VistaEleccionPreparacion extends StatelessWidget {
  const VistaEleccionPreparacion({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Map<String, dynamic>> eventos = [
      {'nombre': 'Preparacion1', 'color': Colors.blue[200], 'Preparacion1':true},
      {'nombre': 'Preparacion2', 'color': Colors.green[200], 'Preparacion2': true},
      {'nombre': 'Preparacion3', 'color': Colors.teal[200], 'Preparacion3': true},
      {'nombre': 'Puesta Punto', 'color': const Color.fromARGB(255, 241, 245, 203), 'puesta':true},
    ];

    return 
      Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.5,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:  16.0, horizontal: 16.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: eventos.length,
                    itemBuilder: (context, index) {
                      return _buildEventCard(context, eventos[index]);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
   
  }

  Widget _buildEventCard(BuildContext context, Map<String, dynamic> evento) {
    return GestureDetector(
      onTap: evento['puesta'] == true
          ? () {
            Navigator.pop(context);
          }
          : evento['produccion'] == true ? () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InicioProduccion()),
              ):  evento['preparacion'] == true ? ()=> Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UnidadesProcesadas()),
              ) : null,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: evento['color'],
        child: Center(
          child: Text(
            evento['nombre'],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
*/


