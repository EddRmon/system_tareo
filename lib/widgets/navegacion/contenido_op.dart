import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_tareo/providers/programa_maquina_provider.dart';
//import 'package:system_tareo/views/navegacion/antes_del_evento.dart';
import 'package:system_tareo/views/navegacion/boton_inicio_preparacion.dart';


class ContenidoOp extends StatefulWidget {
  const ContenidoOp({super.key, required this.codMaq});
  final String? codMaq;

  @override
  State<ContenidoOp> createState() => _ContenidoOpState();
}

class _ContenidoOpState extends State<ContenidoOp> {
  Color circleColor = Colors.green; // Color por defecto

  @override
  void initState() {
    super.initState();
    _loadCircleColor(); // Cargar color desde SharedPreferences
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProgramaMaquinaProvider>().obtenerProgramaMaquina(idMaquina: widget.codMaq);
    });
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
    Color colorAmarillo = const Color(0xFFFFF5CC);
    return SizedBox(
      height: size.height * 0.7,
      child: Consumer<ProgramaMaquinaProvider>(
        builder: (context, maqProgProvData, child) {
          return ListView.builder(
            itemCount: maqProgProvData.progMaquinadata.length,
            itemBuilder: (context, index) {
              final maqdetalle = maqProgProvData.progMaquinadata[index];
              if (maqProgProvData.isLoading) {
                return Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                    color: const Color.fromARGB(255, 96, 125, 139),
                    size: 50
                  ),
                );
              }
              if (maqProgProvData.errorMessage != null) {
                return Center(
                  child: Text(
                    maqProgProvData.errorMessage!,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 107, 25, 25)),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    /*Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                             PreviaEvento(idMaq: widget.codMaq!, op: maqdetalle.motCodOdt!,),
                        transitionDuration: const Duration(milliseconds: 350),
                        transitionsBuilder:
                            (context, animation, animationSecondary, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                                    begin: const Offset(1.0, 0.0),
                                    end: Offset.zero)
                                .animate(animation),
                            child: FadeTransition(
                                opacity: animation, child: child),
                          );
                        },
                      ),
                    );*/
                  },
                  child: Card(
                    elevation: 5,
                    color: colorAmarillo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(color: Colors.green, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'OP: ${maqdetalle.motCodOdt}',
                                style: const TextStyle(
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
                                                         nombEvento: '', tipoProceso: '', motCodOdt: '', secuencyMachine: '', motNroElem: '', odtMaq: '', complement: '',
                                                      )))
                                          : () {},
                                      icon: const Icon(Icons.send))
                                ],
                              )
                            ],
                          ),
                          const Divider(color: Colors.grey),
                          _infoRow2('🏢 Cliente:', maqdetalle.clides),
                          _infoRow2('📦 Descrip: ', maqdetalle.motDescrip),
                          const Divider(color: Colors.grey),
                          _infoRow2('Fecha/Hora Inicio Prod.',
                              '${maqdetalle.iniproc} ${maqdetalle.horaInProc}'),
                          const Divider(color: Colors.grey),
                          _infoRow2('Fecha/Hora Fin Prod.',
                              '${maqdetalle.finproc} ${maqdetalle.horaFinProc}'),
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
                                    _infoRow('Tipo: ', maqdetalle.motTipoMaq),
                                    _infoRow('Tiraje: ', maqdetalle.motPliegos),
                                    _infoRow('Cant: ', maqdetalle.motCant),
                                    _infoRow('T/R: ', maqdetalle.mottirret),
                                  ],
                                ),
                                Container(
                                    height: 120, width: 2, color: Colors.grey),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        const Text('Amp',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 5),
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: maqdetalle
                                                      .estadoAlm ==
                                                  'H'
                                              ? Colors.green
                                              : maqdetalle.estadoAlm == 'C'
                                                  ? Colors.red
                                                  : maqdetalle.estadoAlm == 'D'
                                                      ? Colors.orange
                                                      : maqdetalle.estadoAlm ==
                                                              'DP'
                                                          ? const Color
                                                              .fromARGB(
                                                              255, 78, 25, 223)
                                                          : maqdetalle.estadoAlm ==
                                                                  null
                                                              ? Colors.grey
                                                              : Colors
                                                                  .blueAccent,
                                          child: Center(
                                              child: Text(
                                                  '${maqdetalle.estadoAlm}',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15))),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 2),
                                    Column(
                                      children: [
                                        const Text('Ctp',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 5),
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: maqdetalle
                                                      .estadoCtp ==
                                                  'H'
                                              ? Colors.green
                                              : maqdetalle.estadoCtp == 'C'
                                                  ? Colors.red
                                                  : maqdetalle.estadoCtp == 'D'
                                                      ? Colors.orange
                                                      : maqdetalle.estadoCtp ==
                                                              'DP'
                                                          ? const Color
                                                              .fromARGB(
                                                              255, 78, 25, 223)
                                                          : maqdetalle.estadoCtp ==
                                                                  null
                                                              ? Colors
                                                                  .blueAccent
                                                              : Colors.grey,
                                          child: Center(
                                              child: Text(
                                                  '${maqdetalle.estadoCtp}',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15))),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 2),
                                    Column(
                                      children: [
                                        const Text('Matizad',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 5),
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: maqdetalle
                                                      .estadoMatiz ==
                                                  'H'
                                              ? Colors.green
                                              : maqdetalle.estadoMatiz == 'C'
                                                  ? Colors.red
                                                  : maqdetalle.estadoMatiz ==
                                                          'D'
                                                      ? Colors.orange
                                                      : maqdetalle.estadoMatiz ==
                                                              'DP'
                                                          ? const Color
                                                              .fromARGB(
                                                              255, 78, 25, 223)
                                                          : maqdetalle.estadoMatiz ==
                                                                  null
                                                              ? Colors.grey
                                                              : Colors
                                                                  .blueAccent,
                                          child: Center(
                                              child: Text(
                                                  maqdetalle.estadoMatiz == null
                                                      ? ''
                                                      : '${maqdetalle.estadoMatiz}',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
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
