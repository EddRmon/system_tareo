import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:system_tareo/providers/auth_provider.dart';
import 'package:system_tareo/providers/mostrar_registros_provider.dart';

class RegistroActividades extends StatefulWidget {
  const RegistroActividades({super.key});

  @override
  State<RegistroActividades> createState() => _RegistroActividadesState();
}

class _RegistroActividadesState extends State<RegistroActividades> {
Color colorAmarillo = const Color(0xFFFFF5CC);
  
  final Map<String, Map<String, dynamic>> datosPorFecha = {
    '02/05/2020': {
      'colorInicio': Colors.blue[100]!,
      'colorFin': Colors.blue[300]!,
      'horaInicio': '08:00',
      'horaFin': '16:30',
    },
    '03/05/2020': {
      'colorInicio': Colors.green[100]!,
      'colorFin': Colors.green[300]!,
      'horaInicio': '07:45',
      'horaFin': '15:50',
    },
    '04/05/2020': {
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
          index * 50.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
      final idOper = context.read<AuthProvider>().idOperadors;
      final fechaApi = DateFormat('yyyy-MM-dd')
          .format(DateFormat('dd/MM/yyyy').parse(fechaSeleccionada));
      context.read<MostrarRegistrosProvider>().obtenerRegistros(
            fecha: fechaApi,
            idusuario: idOper,
          );
    });
  }

  List<String> _generarFechasDelMes() {
    DateTime fechaBase = DateTime(2020, 5, 1); // Mayo de 2020
    int daysInMonth = DateTime(fechaBase.year, fechaBase.month + 1, 0).day;
    List<String> fechas = [];

    for (int i = 1; i <= daysInMonth; i++) {
      String fecha = DateFormat('dd/MM/yyyy')
          .format(DateTime(fechaBase.year, fechaBase.month, i));
      fechas.add(fecha);
    }
    return fechas;
  }

  String _obtenerFechaActual() {
    return '12/05/2020'; // Fecha inicial de mayo de 2020
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CarouselSlider(
                  items: imagenes.map((img) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        img,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                      height: 150.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 4))),
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
                          final idOper =
                              context.read<AuthProvider>().idOperadors;
                          final fechaApi = DateFormat('yyyy-MM-dd')
                              .format(DateFormat('dd/MM/yyyy').parse(fecha));
                          context
                              .read<MostrarRegistrosProvider>()
                              .obtenerRegistros(
                                fecha: fechaApi,
                                idusuario: idOper,
                              );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: fecha == fechaSeleccionada
                                ? const Color.fromARGB(255, 118, 133, 216)
                                :  colorAmarillo ,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              fecha,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
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
              const Text('Trabajo realizado:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width,
                height: 500,
                child: Consumer<MostrarRegistrosProvider>(
                  builder: (context, regProv, child) {
                    if (regProv.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (regProv.errorMessage != null) {
                      return Center(
                          child: Text(
                        regProv.errorMessage!,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 118, 133, 216)),
                      ));
                    }
                    if (regProv.registros.isEmpty) {
                      return const Center(
                          child: Text('No hay registros para esta fecha'));
                    }
                    return ListView.builder(
                      itemCount: regProv.registros.length,
                      itemBuilder: (context, index) {
                        final regist = regProv.registros[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 118, 133, 216),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 8),
                              ],
                            ),
                            child: Column(
                              children: [
                                filaContenido(
                                    icono: Icons.numbers,
                                    texto1: 'OP',
                                    texto2: regist.odtCod),
                                const Divider(),
                                filaContenido(
                                    icono: Icons.event,
                                    texto1: 'Tipo de evento:',
                                    texto2: regist.description ??
                                        'Sin descripción'),
                                const Divider(),
                                filaContenido(
                                    icono: Icons.electric_meter_rounded,
                                    texto1: 'Elemento:',
                                    texto2: regist.odtEle),
                                const Divider(),
                                filaContenido(
                                    icono: Icons.date_range,
                                    texto1: 'Fecha Inicio:',
                                    texto2: regist.fecIniProc),
                                const Divider(),
                                filaContenido(
                                    icono: Icons.dataset,
                                    texto1: 'Fecha final:',
                                    texto2: regist.fecFinProc),
                                const Divider(),
                                filaContenido(
                                    icono: Icons.thumb_up,
                                    texto1: 'Pliegos buenos:',
                                    texto2: regist.pliegosParc),
                                const Divider(),
                                filaContenido(
                                    icono: Icons.thumb_down,
                                    texto1: 'Pliegos malos:',
                                    texto2: regist.pliegosparcmal ?? '0'),
                                const Divider(),
                                filaContenido(
                                    icono: Icons.table_chart,
                                    texto1: 'Pliegos malos:',
                                    texto2: regist.odtObs ??
                                        'no hay observaciones'),
                                const Divider(),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row filaContenido(
      {required IconData icono,
      required String texto1,
      required String texto2}) {
    return Row(
      children: [
        Icon(
          icono,
          color: Colors.black,
          size: 18,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$texto1  $texto2',
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
