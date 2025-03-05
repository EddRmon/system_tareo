import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegistroActividades extends StatefulWidget {
  const RegistroActividades({super.key});

  @override
  State<RegistroActividades> createState() => _RegistroActividadesState();
}

class _RegistroActividadesState extends State<RegistroActividades> {
  final Map<String, Map<String, dynamic>> datosPorFecha = {
    '02/03/2025': {
      'colorInicio': Colors.blue[100]!,
      'colorFin': Colors.blue[300]!,
      'horaInicio': '08:00',
      'horaFin': '16:30',
    },
    '03/03/2025': {
      'colorInicio': Colors.green[100]!,
      'colorFin': Colors.green[300]!,
      'horaInicio': '07:45',
      'horaFin': '15:50',
    },
    '04/03/2025': {
      'colorInicio': Colors.orange[100]!,
      'colorFin': Colors.orange[300]!,
      'horaInicio': '09:00',
      'horaFin': '17:20',
    },
  };

  final List<String> imagenes = [
    'https://images.pexels.com/photos/6620970/pexels-photo-6620970.jpeg?auto=compress&cs=tinysrgb&w=300',
    'https://images.pexels.com/photos/6620989/pexels-photo-6620989.jpeg?auto=compress&cs=tinysrgb&w=300',
    'https://media.istockphoto.com/id/475690164/es/foto/despu%C3%A9s-de-alcanzar-la-l%C3%ADnea-de-meta-de-m%C3%A1quina-de-prensa.jpg?b=1&s=612x612&w=0&k=20&c=u7yqwEDQgYbvEGvyKU4kuB_ySMi_IOXPGDQof6HVidY=',
    'https://media.istockphoto.com/id/519913201/es/foto/impresi%C3%B3n-a-internet-de-alta-velocidad.jpg?b=1&s=612x612&w=0&k=20&c=97dAXtLBrcs6m6XlXqz6OvLYdN7yJ3GjWjTP3kR0BXc=',
    'https://media.istockphoto.com/id/475690164/es/foto/despu%C3%A9s-de-alcanzar-la-l%C3%ADnea-de-meta-de-m%C3%A1quina-de-prensa.jpg?b=1&s=612x612&w=0&k=20&c=u7yqwEDQgYbvEGvyKU4kuB_ySMi_IOXPGDQof6HVidY='
   
  ];

  List<String> fechasDelMes = [];
  String fechaSeleccionada = '';
  final ScrollController _scrollController = ScrollController();

  @override
void initState() {
  super.initState();
  fechasDelMes = _generarFechasDelMes();
  fechaSeleccionada = _obtenerFechaActual();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final index = fechasDelMes.indexOf(fechaSeleccionada);
    if (index != -1) {
      _scrollController.animateTo(
        index * 50.0, // Ajusta este valor según el tamaño del contenedor
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  });
}

  /// Genera todas las fechas del mes en formato dd/MM/yyyy
  List<String> _generarFechasDelMes() {
    DateTime now = DateTime.now();
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    List<String> fechas = [];

    for (int i = 1; i <= daysInMonth; i++) {
      String fecha = DateFormat('dd/MM/yyyy').format(DateTime(now.year, now.month, i));
      fechas.add(fecha);
    }
    return fechas;
  }

  String _obtenerFechaActual() {
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final datos = datosPorFecha[fechaSeleccionada] ?? {
      'colorInicio': Colors.grey[300]!,
      'colorFin': Colors.grey[500]!,
      'horaInicio': '--:--',
      'horaFin': '--:--',
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CarouselSlider(
                items: imagenes.map((img){
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(img, fit: BoxFit.cover,
                    width: double.infinity,),
                  );
                }).toList(), 
                options: CarouselOptions(
                  height: 150.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4)
                )
              ),
              // Sección de Fechas en formato LINEAL
              //const Text('Seleccione una fecha:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: fechasDelMes.map((fecha) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            fechaSeleccionada = fecha;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: fecha == fechaSeleccionada ? Colors.redAccent[700] : const Color.fromARGB(255, 75, 128, 163),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              fecha,
                              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text('Trabajo realizado:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(height: 10),

              // Tarjeta de Información
              _buildInfoCard(
                context,
                color: datos['colorInicio'],
                icon: Icons.play_arrow,
                label: 'Hora inicio:',
                value: datos['horaInicio'],
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                context,
                color: datos['colorFin'],
                icon: Icons.flag,
                label: 'Hora Fin:',
                value: datos['horaFin'],
              ),
            ],
          ),
        ),
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
        Icon(
          icon,
          color: Colors.black87,
          size: 18,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$label  $value',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
