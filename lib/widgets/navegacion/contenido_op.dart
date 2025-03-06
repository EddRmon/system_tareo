import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_tareo/views/navegacion/boton_inicio_preparacion.dart';
import 'package:system_tareo/views/navegacion/eventos.dart';

class ContenidoOp extends StatefulWidget {
  const ContenidoOp({super.key});

  @override
  State<ContenidoOp> createState() => _ContenidoOpState();
}

class _ContenidoOpState extends State<ContenidoOp> {
  Color circleColor = Colors.green; // Color por defecto

  @override
  void initState() {
    super.initState();
    _loadCircleColor(); // Cargar color desde SharedPreferences
  }

  Future<void> _loadCircleColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt('circleColor');
    print('Color cargado: $colorValue');
    setState(() {
      circleColor = colorValue != null ? Color(colorValue) : Colors.green;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.7,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const TiposEventos(),
                    transitionDuration: const Duration(milliseconds: 350),
                    transitionsBuilder:
                        (context, animation, animationSecondary, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                                begin: const Offset(1.0, 0.0), end: Offset.zero)
                            .animate(animation),
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                  ),
                );
              },
              child: Card(
                elevation: 5,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(color: Colors.green, width: 1),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'OP: 164331',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                circleColor == const Color(0xfff44336)
                                    ? 'Pendiente'
                                    : 'No hay pendientes',
                                style: TextStyle(
                                    color: circleColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              /*Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: circleColor, // Color dinámico
                            ),
                          ),*/
                              IconButton(
                                  onPressed: circleColor ==
                                          const Color(0xfff44336)
                                      ? () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BotonInicioPreparacion(
                                                    texto: '',
                                                  )))
                                      : () {},
                                  icon: const Icon(Icons.send))
                            ],
                          )
                        ],
                      ),
                      const Divider(color: Colors.grey),
                      _infoRow2('🏢 Cliente:', 'INSTITUTO QUIMIOTERAPICO S.A.'),
                      _infoRow2('📦 Descrip:',
                          'EMV07714 SULFATO FERROSO 75MG/5ML JARABE CAJA X 180 ML - 54X54X140MM'),
                      const Divider(color: Colors.grey),
                      _infoRow2('Fecha/Hora Inicio', '05/03/2025 15:33:00'),
                      const Divider(color: Colors.grey),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _infoRow('Tipo: ', 'impresora'),
                                _infoRow('Tiraje: ', '15900'),
                                _infoRow('Cant: ', '45000'),
                                _infoRow('T/R: ', 'T'),
                              ],
                            ),
                            Container(
                                height: 120, width: 2, color: Colors.grey),
                            const Row(
                              children: [
                                Column(
                                  children: [
                                    Text('Amp',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.green,
                                      child: Center(
                                          child: Text('H',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15))),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 2),
                                Column(
                                  children: [
                                    Text('Ctp',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.red,
                                      child: Center(
                                          child: Text('D',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15))),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 2),
                                Column(
                                  children: [
                                    Text('Matizad',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.yellow,
                                      child: Center(
                                          child: Text('',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20))),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _infoRow(String title, String value,
      {Color textColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
          Text(value, style: TextStyle(color: textColor)),
        ],
      ),
    );
  }

  Widget _infoRow2(String title, String value,
      {Color textColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
              child: Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: textColor))),
          Expanded(
              flex: 7, child: Text(value, style: TextStyle(color: textColor))),
        ],
      ),
    );
  }
}
