import 'package:flutter/material.dart';
import 'package:system_tareo/widgets/navegacion/contenido_op.dart';

class BuscarOpPendiente extends StatefulWidget {
  const BuscarOpPendiente({super.key, required this.idMaquina});
  final String? idMaquina;

  @override
  State<BuscarOpPendiente> createState() => _BuscarOpPendienteState();
}

class _BuscarOpPendienteState extends State<BuscarOpPendiente> {
  final TextEditingController _buscar = TextEditingController();
  String? selectedPreparationOption;
  late VoidCallback resetTiposEventos = () {};

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          
          children: [
            // Cabecera de la pagina principal

            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 2, top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: SizedBox(
                      width: size.width * 0.6,
                      height: 40,
                      child: TextField(
                        controller: _buscar,
                        style: const TextStyle(fontSize: 12),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: '🔍  Buscar OP...',
                          hintStyle:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 22, 56, 78),
                              )),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 22, 56, 78),
                              ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                        ),
                      ),
                    ),
                  ),
                   
                  ////
                  
                ],
              ),
            ),
            // Cuerpo de la vista
             ContenidoOp(codMaq: widget.idMaquina,),
          ],
        ),
      ),
    );
  }
  
}
