import 'package:flutter/material.dart';

const tipoLetra = 'Monospace';

class RegistroActividades extends StatefulWidget {
  const RegistroActividades({super.key});

  @override
  State<RegistroActividades> createState() => _RegistroActividadesState();
}

class _RegistroActividadesState extends State<RegistroActividades> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
                const SizedBox(height: 20),
                _buildInfoCard(
                  context,
                  color: Colors.grey[100]!,
                  icon: Icons.play_arrow,
                  label: 'Fecha inicio:',
                  value: '10:12',
                ),
                const SizedBox(height: 20),
                _buildInfoCard(
                  context,
                  color: Colors.red[100]!,
                  icon: Icons.flag,
                  label: 'Fecha Fin:',
                  value: '11:59',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, {required Color color, required IconData icon, required String label, required String value}) {
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
          const InfoRow(icon: Icons.event_available_outlined, label: 'Tipo de Evento:', value: 'Producción'),
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
        Icon(icon, color: Colors.black87, size: 18,),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$label  $value',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}