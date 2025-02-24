import 'package:flutter/material.dart';
import 'package:system_tareo/views/inicio_evento.dart';
import 'package:system_tareo/views/navegacion/eventos.dart';
import 'package:system_tareo/widgets/navegacion/contenido_op.dart';

class BuscarOpPendiente extends StatefulWidget {
  const BuscarOpPendiente({super.key});

  @override
  State<BuscarOpPendiente> createState() => _BuscarOpPendienteState();
}

class _BuscarOpPendienteState extends State<BuscarOpPendiente> {
  final TextEditingController _buscar = TextEditingController();
  String estadoconfir = '0';

  String estadoMaquina = "En espera";
  Color estadoColor = Colors.grey;
  bool produciendo = false;

  void iniciarProduccion() {
    setState(() {
      if (produciendo) {
        estadoMaquina = "Finalizado";
        estadoColor = Colors.grey;
      } else {
        estadoMaquina = "Produciendo";
        estadoColor = Colors.green;
      }
      produciendo = !produciendo;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextField(
                controller: _buscar,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, size: 20),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Color.fromARGB(255, 221, 238, 245),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            const ContenidoOp(), // resultado de la búsqueda
            SizedBox(height: size.height * 0.3),
            TiposEventos(event: estadoconfir),
            
          ],
        ),
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          iniciarProduccion();
          if (!produciendo) { // Cuando produciendo es true, el botón es rojo y muestra "FINALIZAR"
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UnidadesProcesadas()),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: produciendo ? Colors.red : Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: SizedBox(
          width: size.width * 0.3,
          height: 20,
          child: Center(
            child: Text(
              produciendo ? "FINALIZAR" : "INICIAR",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}