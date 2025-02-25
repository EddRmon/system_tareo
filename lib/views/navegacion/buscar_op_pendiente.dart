import 'package:flutter/material.dart';
import 'package:system_tareo/widgets/navegacion/contenido_op.dart';

class BuscarOpPendiente extends StatefulWidget {
  const BuscarOpPendiente({super.key});

  @override
  State<BuscarOpPendiente> createState() => _BuscarOpPendienteState();
}

class _BuscarOpPendienteState extends State<BuscarOpPendiente> {
  final TextEditingController _buscar = TextEditingController();
  String? selectedPreparationOption;
  late VoidCallback resetTiposEventos = () {};
 // 🔹 Variable para guardar la función de reset

  @override
  Widget build(BuildContext context) {
   // final size = MediaQuery.of(context).size;

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
                  fillColor: Color.fromARGB(255, 238, 238, 238),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            const ContenidoOp(),
           
            
          ],
        ),
      ),
      
    );
  }
}
