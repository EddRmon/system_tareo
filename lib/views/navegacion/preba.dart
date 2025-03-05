import 'package:flutter/material.dart';

const tipoLetra = 'Monospace';

class RegistroActividades extends StatefulWidget {
  const RegistroActividades({super.key});

  @override
  State<RegistroActividades> createState() => _RegistroActividadesState();
}

class _RegistroActividadesState extends State<RegistroActividades> {
  final Map<String, Map<String, dynamic>> datosPorFecha = {
    '22/08/2025': {
      'colorInicio': Colors.blue[100]!,
      'colorFin': Colors.blue[300]!,
      'horaInicio': '08:00',
      'horaFin': '16:30',
    },
    '23/08/2025': {
      'colorInicio': Colors.green[100]!,
      'colorFin': Colors.green[300]!,
      'horaInicio': '07:45',
      'horaFin': '15:50',
    },
    '24/08/2025': {
      'colorInicio': Colors.orange[100]!,
      'colorFin': Colors.orange[300]!,
      'horaInicio': '09:00',
      'horaFin': '17:20',
    },
    '25/08/2025': {
      'colorInicio': Colors.red[100]!,
      'colorFin': Colors.red[300]!,
      'horaInicio': '06:30',
      'horaFin': '14:50',
    },
    '26/08/2025': {
      'colorInicio': Colors.purple[100]!,
      'colorFin': Colors.purple[300]!,
      'horaInicio': '10:00',
      'horaFin': '18:00',
    },
    '27/08/2025': {
      'colorInicio': Colors.teal[100]!,
      'colorFin': Colors.teal[300]!,
      'horaInicio': '07:30',
      'horaFin': '16:00',
    },
    '28/08/2025': {
      'colorInicio': Colors.purple[100]!,
      'colorFin': Colors.purple[300]!,
      'horaInicio': '10:00',
      'horaFin': '18:00',
    },
    '29/08/2025': {
      'colorInicio': Colors.teal[100]!,
      'colorFin': Colors.teal[300]!,
      'horaInicio': '07:30',
      'horaFin': '16:00',
    },
    '30/08/2025': {
      'colorInicio': Colors.teal[100]!,
      'colorFin': Colors.teal[300]!,
      'horaInicio': '07:30',
      'horaFin': '16:00',
    },
    
  };

  String fechaSeleccionada = '22/08/2025';

  @override
  Widget build(BuildContext context) {
    final datos = datosPorFecha[fechaSeleccionada] ?? datosPorFecha['22/08/2025']!;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Registro por fecha', overflow: TextOverflow.visible),
              const SizedBox(height: 10),
              // Botones organizados en 3 por fila
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  child: SizedBox(
                    height: 100,
                    width: size.width * 0.75, // Ajustar la altura según necesidad
                    child: GridView.count(
                      crossAxisCount: 3, // 3 botones por fila
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      shrinkWrap: true,
                      childAspectRatio: 3.5,
                      physics: const NeverScrollableScrollPhysics(),
                      children: datosPorFecha.keys.map((fecha) {
                        return botones(fecha: fecha);
                      }).toList(),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              _buildInfoCard(
                context,
                color: datos['colorInicio'],
                icon: Icons.play_arrow,
                label: 'Fecha inicio:',
                value: datos['horaInicio'],
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                context,
                color: datos['colorFin'],
                icon: Icons.flag,
                label: 'Fecha Fin:',
                value: datos['horaFin'],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton botones({required String fecha}) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          fechaSeleccionada = fecha;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: fechaSeleccionada == fecha ? Colors.black : Colors.white,
        foregroundColor: fechaSeleccionada == fecha ? Colors.white : Colors.black,
        side: const BorderSide(color: Colors.black, width: 1),
        padding: const EdgeInsets.symmetric(vertical: 5),
      ),
      child: Text(
        fecha,
        style: const TextStyle(fontSize: 10),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context,
      {required Color color,
      required IconData icon,
      required String label,
      required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(icon: icon, label: label, value: value),
          const Divider(color: Colors.black),
          const InfoRow(icon: Icons.thumb_up, label: 'Buenas:', value: '4000'),
          const Divider(color: Colors.black),
          const InfoRow(icon: Icons.thumb_down, label: 'Malas:', value: '30'),
          const Divider(color: Colors.black),
          const InfoRow(
              icon: Icons.event_available_outlined,
              label: 'Tipo de Evento:',
              value: 'Producción'),
        ],
      ),
    );
  }
}
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.black87,
          size: 18,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$label  $value',
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontFamily: 'Times New Roman'),
          ),
        ),
      ],
    );
  }
}

