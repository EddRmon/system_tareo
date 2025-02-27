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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Cabecera de la pagina principal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SizedBox(
                width: size.width,
                height: 40,
                child: TextField(
                  controller: _buscar,
                  style: const TextStyle(fontSize: 12),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: 'Buscar OP',
                    hintStyle:
                        const TextStyle(fontSize: 12, color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, size: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 236, 236, 236),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  ),
                ),
              ),
            ),
            // Cuerpo de la vista
            const ContenidoOp(),
          ],
        ),
      ),
    );
  }
}
