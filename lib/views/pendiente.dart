import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_tareo/providers/prendiente.dart';



class EstadoProcesoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Estado del Proceso')),
      body: Center(
        child: Consumer<ProcesoProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                ElevatedButton(
                  onPressed: provider.cambiarEstado, // Cambia el estado al presionar
                  style: ElevatedButton.styleFrom(
                    backgroundColor: provider.procesoPendiente ? Colors.red : Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  ),
                  child: Text(
                    provider.procesoPendiente ? 'Pendiente' : 'Finalizado',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),

                ElevatedButton(
                  onPressed: (){
                   // Navigator.push(context, MaterialPageRoute(builder: (_) => const BotonInicioPreparacion()));
                  }, // Cambia el estado al presionar
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  ),
                  child: const Text(
                    'Verificar',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
