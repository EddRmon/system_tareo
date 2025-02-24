import 'package:flutter/material.dart';
import 'package:system_tareo/views/inicio_evento.dart';

class OpcionesDialogScreen extends StatefulWidget {
  const OpcionesDialogScreen({super.key});

  @override
  State<OpcionesDialogScreen> createState() => _OpcionesDialogScreenState();
}

class _OpcionesDialogScreenState extends State<OpcionesDialogScreen> {
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

  final List<Map<String, dynamic>> opciones = [
    {'icon': Icons.check_box, 'text': 'Puesta a Punto', 'color': Colors.green},
    {'icon': Icons.settings, 'text': 'Mantenimiento', 'color': Colors.orange},
    {'icon': Icons.build, 'text': 'Revisión Técnica', 'color': Colors.red},
    {'icon': Icons.work, 'text': 'Producción Especial', 'color': Colors.teal},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Preparación")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: SizedBox(
          width: double.maxFinite,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 columnas
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2,
            ),
            itemCount: opciones.length,
            itemBuilder: (context, index) {
              return _buildGridOptionButton(
                context,
                opciones[index]['icon'],
                opciones[index]['text'],
                opciones[index]['color'],
                () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const UnidadesProcesadas() ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Seleccionaste: ${opciones[index]['text']}')),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ElevatedButton(
              onPressed: (){
                iniciarProduccion();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: produciendo ? Colors.red : Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
              ),
              child: SizedBox(width: size.width * 0.3, height: 20, child: Center(child: Text(produciendo ? "FINALIZAR" : "INICIAR", style: const TextStyle(color: Colors.white),)),)
            ),
    );
  }

  Widget _buildGridOptionButton(BuildContext context, IconData icon,
      String text, Color color, VoidCallback onTap) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      icon: Icon(icon, size: 24),
      label: Text(text, style: const TextStyle(fontSize: 14)),
      onPressed: onTap,
    );
  }
}
