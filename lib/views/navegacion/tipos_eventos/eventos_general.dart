import 'package:flutter/material.dart';
import 'package:system_tareo/views/navegacion/boton_inicio_produccion.dart';

class EventosGeneral extends StatelessWidget {
  const EventosGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {"text": "INASISTENCIA PERSONAL", "gradient": const [Colors.red, Color.fromARGB(255, 112, 74, 87)]},
      {"text": "LAVADO DE BATERIA", "gradient": const [Colors.teal, Colors.green]},
      {"text": "LIMPIEZA DE MANTILLA", "gradient": const [Colors.orange, Colors.pink]},
      {"text": "LIMPIEZA DE MAQUINA", "gradient": const [Colors.yellow, Colors.orange]},
      {"text": "MANTENIMIENTO CORRECTIVO", "gradient": const [Colors.purple, Colors.red]},
      {"text": "MANTENIMIENTO INTEGRAL", "gradient": const [Colors.blue, Colors.lightBlueAccent]},
      {"text": "MANTENIMIENTO OPERACIONAL", "gradient": const [Colors.red, Colors.orange]},
      {"text": "MANTENIMIENTO PREVENTIVO", "gradient": const [Colors.brown, Colors.orange]},
      {"text": "MAQUINA INOPERATIVA", "gradient": const [Colors.brown, Colors.orange]},
      {"text": "PASE ADICIONAL", "gradient": const [Colors.brown, Colors.orange]},
      {"text": "PATRON DE COLOR", "gradient": const [Colors.brown, Colors.orange]},
      {"text": "PERFILACION DE MAQUINA", "gradient": const [Colors.brown, Color.fromARGB(255, 189, 210, 211)]},
      {"text": "AJUSTE DE IMPRESIÓN", "gradient": const [Color.fromARGB(255, 199, 86, 45), Color.fromARGB(255, 241, 10, 10)]},
      {"text": "AJUSTE DE PRESION", "gradient": const [Colors.brown, Colors.orange]},
      {"text": "APOYO A OTRA AREA", "gradient": const [Colors.brown, Color.fromARGB(255, 6, 182, 21)]},
      {"text": "CALADO DE BARNIZ", "gradient": const [Colors.brown, Colors.orange]},
      {"text": "CAMBIO DE CITO", "gradient": const [Colors.brown, Colors.orange]},
      {"text": "CAMBIO DE CUCHILLA", "gradient": const [Colors.brown, Colors.orange]},
      {"text": "CAMBIO DE MANTILLA O PLACA", "gradient": const [Colors.brown, Colors.orange]},
      {"text": "CAMBIO DE PROGRAMACION - PCP", "gradient": const [Colors.brown, Colors.orange]},
      {"text": "CAPACITACION - REUNION", "gradient": const [Colors.brown, Colors.orange]},
      {"text": "CORRECCIÓN DE CURVA", "gradient": const [Colors.brown, Colors.orange]},
      {"text": "CORRECCIÓN DE TROQUEL", "gradient": const [Colors.brown, Colors.orange]},
      {"text": "DEFECTO DEL MATERIAL", "gradient": const [Colors.brown, Color.fromARGB(255, 204, 203, 133)]},
      {"text": "SIN CARGA", "gradient": const [Colors.brown, Colors.orange]},
      {"text": "SIN CARGA CONPENSA FERIADO", "gradient": const [Colors.brown, Color.fromARGB(255, 14, 192, 38)]},
      {"text": "SIN CARGA DOMINGO", "gradient": const [Color.fromARGB(255, 112, 42, 97), Color.fromARGB(255, 24, 168, 101)]},
      {"text": "SIN CARGA FERIADO", "gradient": const [Colors.brown, Colors.orange]},
      {"text": "SIN CARGA POR FALTA DE MATERIA PRIMA", "gradient": const [Colors.brown, Color.fromARGB(255, 53, 151, 110)]},
      {"text": "TRASLADO DE MAQUINA", "gradient": const [Colors.brown, Color.fromARGB(255, 133, 118, 97)]},
      {"text": "Z5", "gradient": const [Colors.brown, Color.fromARGB(255, 81, 182, 84)]},
    ];

    final size = MediaQuery.of(context).size;
    final isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              const Text(
                'Eventos',
                style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(color: Colors.black),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isLandScape ? 3 : 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  InicioProduccion(texto: '${item['text']}',) ));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Seleccionaste: ${item['text']}"),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(colors: item['gradient']),
                            ),
                            child: Center(
                              child: Text(
                                item['text'],
                                style: TextStyle(
                                  fontSize: isLandScape ? size.height * 0.04 : size.height * 0.02,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
