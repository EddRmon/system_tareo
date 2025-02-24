import 'package:flutter/material.dart';
import 'package:system_tareo/views/navegacion/boton_inicio_produccion.dart';
//import 'package:system_tareo/views/navegacion/nuevo.dart';
import 'package:system_tareo/views/navegacion/tipos_eventos/eventos_general.dart';


class TiposEventos extends StatefulWidget {
  const TiposEventos({super.key, required this.event});
  final String event;

  @override
  State<TiposEventos> createState() => _TiposEventosState();
}

class _TiposEventosState extends State<TiposEventos> {
  final tipoEvento = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Map<String, dynamic>> eventos = [
      {'nombre': 'Preparación', 'color': Colors.blue[300], 'preparacion': true},
      {'nombre': 'Producción', 'color': Colors.green[400], 'produccion': true},
      {'nombre': 'Eventos Generales', 'color': Colors.teal[300], 'navigate': true},
    ];

    return SizedBox(
      height: size.height * 0.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0,
          ),
          itemCount: eventos.length,
          itemBuilder: (context, index) {
            return _buildEventCard(context, eventos[index]);
          },
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, Map<String, dynamic> evento) {
  return GestureDetector(
    onTap: () {
      if (evento['preparacion'] == true) {
        //Navigator.push(context, MaterialPageRoute(builder: (context) => const OpcionesDialogScreen()));
        _showOptionsDialog(context, evento); // Muestra el AlertDialog solo para "Preparación"
      } else if (evento['produccion'] == true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InicioProduccion(texto: '',)),
        );
      } else if (evento['navigate'] == true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EventosGeneral()),
        );
      }
    },
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: evento['color'],
      child: Center(
        child: Text(
          evento['nombre'],
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.bold, 
            color: Colors.white
          ),
        ),
      ),
    ),
  );
}

  void _showOptionsDialog(BuildContext context, Map<String, dynamic> evento) {
  final List<Map<String, dynamic>> opciones = [
    
    {'icon': Icons.check_box, 'text': 'Puesta a Punto', 'color': Colors.green},
    {'icon': Icons.settings, 'text': 'Mantenimiento', 'color': Colors.orange},
    {'icon': Icons.build, 'text': 'Revisión Técnica', 'color': Colors.red},
    {'icon': Icons.work, 'text': 'Producción Especial', 'color': Colors.teal},
  ];

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          "Opciones para ${evento['nombre']}",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 3 columnas
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2, // Ajusta la proporción de los botones
            ),
            itemCount: opciones.length,
            itemBuilder: (context, index) {
              return _buildGridOptionButton(
                context,
                opciones[index]['icon'],
                opciones[index]['text'],
                opciones[index]['color'],
                () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Seleccionaste: ${opciones[index]['text']}')),
                  );
                },
              );
            },
          ),
        ),
      );
    },
  );
}

Widget _buildGridOptionButton(BuildContext context, IconData icon, String text, Color color, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2)),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 10, color: Colors.white),
          const SizedBox(height: 5),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}


}
