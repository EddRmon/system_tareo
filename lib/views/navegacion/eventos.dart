import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_tareo/providers/auth_provider.dart';
import 'package:system_tareo/providers/insertar_inicio_evento_provider.dart';
import 'package:system_tareo/providers/op_fecha_provider.dart';
import 'package:system_tareo/views/eventos_general_screen.dart';
import 'package:system_tareo/views/navegacion/boton_padre_produccion.dart';
import 'package:system_tareo/views/navegacion/preparacion_screen.dart';

class TiposEventos extends StatefulWidget {
  const TiposEventos(
      {super.key,
      required this.motCodOdt,
      required this.secuencyMachine,
      required this.motNroElem,
      required this.odtMaq,
      required this.complement,
      required this.generado});
  final String motCodOdt;
  final String secuencyMachine;
  final String motNroElem;
  final String odtMaq;
  final String complement;
  final String generado;

  @override
  State<TiposEventos> createState() => _TiposEventosState();
}

class _TiposEventosState extends State<TiposEventos> {
  int _currentPage = 0;
  late PageController _pageController;
  bool _mostrarLista = false; // Estado para alternar entre lista y grid

  final List<Map<String, dynamic>> eventos = [
    {
      'nombre': 'Preparación',
      'icon': Icons.build,
      'color': Colors.blue,
      'preparacion': true
    },
    {
      'nombre': 'Producción',
      'icon': Icons.factory,
      'color': Colors.green,
      'produccion': true
    },
    {
      'nombre': 'Eventos Generales',
      'icon': Icons.event,
      'color': Colors.teal,
      'navigate': true
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OpFechaProvider>().obtenerfechasOp(widget.motCodOdt);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _saveTime() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    await prefs.setString('savedTime', formattedTime);
    await prefs.setInt(
        'circleColor', Colors.red.value); // Cambiar a rojo al iniciar
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          /// SliverAppBar con imagen de fondo
          SliverAppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Eventos',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              background: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqemOVOTgtrtRoQNkL27_oQyO40CSA7p4ozw&s',
                fit: BoxFit.cover,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 113, 153, 168),
          ),

          /// Botones para cambiar entre SliverList y GridView
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      iconSize: 30,
                      color: Colors.white,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        setState(() {
                          _mostrarLista = false; // Mostrar GridView
                        });
                      },
                      icon: const Icon(Icons.grid_view)),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      iconSize: 30,
                      color: Colors.white,
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 170, 55, 236)),
                      onPressed: () {
                        setState(() {
                          _mostrarLista = true; // Mostrar SliverList
                        });
                      },
                      icon: const Icon(Icons.list)),
                ],
              ),
            ),
          ),

          /// Contenedor de los eventos (GridView o SliverList según el estado)
          _mostrarLista ? _buildSliverList(size) : _buildSliverGrid(size),
        ],
      ),
    );
  }

  /// Construcción del SliverGrid
  Widget _buildSliverGrid(Size size) {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: size.width > 600 ? 3 : 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final evento = eventos[index];
            return _buildEventCard(evento, size, index == _currentPage, () {
              _navigateToEvent(evento);
            });
          },
          childCount: eventos.length,
        ),
      ),
    );
  }

  /// Construcción del SliverList
  Widget _buildSliverList(Size size) {
    return Consumer<OpFechaProvider>(
      builder: (context, opfech, child) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final ind = opfech.opFechas[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 4,
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                          color: ind.enProceso == '1'
                              ? Colors.blueGrey
                              : Colors.green,
                          width: 1.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(
                            icon: Icons.numbers,
                            label: "OP",
                            value: ind.odtCod,
                            color: Colors.black87,
                          ),
                          const Divider(),
                          _buildInfoRow(
                            icon: Icons.assignment,
                            label: "Estado",
                            value: ind.enProceso,
                            color: Colors.blueAccent,
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: opfech.opFechas
                .length, // Cambia esto según la cantidad de elementos que desees mostrar
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(
      {required IconData icon,
      required String label,
      required String value,
      Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: color ?? Colors.black54, size: 20),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: color ?? Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  /// Construcción de cada tarjeta en el GridView
  Widget _buildEventCard(Map<String, dynamic> evento, Size size,
      bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: evento['color'].withOpacity(isSelected ? 0.9 : 0.7),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(evento['icon'], color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(
              evento['nombre'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToEvent(Map<String, dynamic> evento) async {
    final idUser = context.read<AuthProvider>().idOperadors;
    if (evento['preparacion'] == true) {
      Navigator.push(
          context,
          _slideTransition(PreparacionScreen(
              tipoProceso: '0',
              motCodOdt: widget.motCodOdt,
              secuencyMachine: widget.secuencyMachine,
              motNroElem: widget.motNroElem,
              odtMaq: widget.odtMaq,
              complement: widget.complement,
              generado: widget.generado)));
    } else if (evento['produccion'] == true) {
      _saveTime();

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                  color: const Color.fromARGB(255, 63, 80, 177), size: 50),
            );
          });

      try {
        await context.read<InsertarEventoProvider>().insertarEvento(
            nrop: widget.motCodOdt,
            complemento: widget.complement,
            elemento: widget.motNroElem,
            secuencia: widget.secuencyMachine,
            idmaquina: widget.odtMaq,
            estadog: widget.generado,
            idoperador: idUser,
            tipoproceso: '1',
            codeevento: '0');

        if (mounted) {
          Navigator.of(context).pop();
        }
        // Navegar a la siguiente pantalla después de completar la operación
        Navigator.push(
          context,
          _slideTransition(BotonPadreProduccion(
            texto: 'produccion',
            tipoProceso: '1',
            motCodOdt: widget.motCodOdt,
            secuencyMachine: widget.secuencyMachine,
            motNroElem: widget.motNroElem,
            odtMaq: widget.odtMaq,
            complement: widget.complement,
            generado: widget.generado,
          )),
        );
      } catch (error) {
        // Cerrar el diálogo si hay un error
        if (mounted) {
          Navigator.of(context).pop();
        }

        // Mostrar un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error al enviar datos: $error"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else if(evento['navigate'] == true){
       Navigator.push(
      context,
      _slideTransition(const EventosGeneralScreen(
        tipoProceso: '2',
      )),
    );
    }
  }

  /*void _navigateToEvent3(Map<String, dynamic> evento) {
    if (evento['preparacion'] == true) {
      Navigator.push(
          context,
          _slideTransition(PreparacionScreen(
              tipoProceso: '0',
              motCodOdt: widget.motCodOdt,
              secuencyMachine: widget.secuencyMachine,
              motNroElem: widget.motNroElem,
              odtMaq: widget.odtMaq,
              complement: widget.complement,
              generado: widget.generado)));
    } else if (evento['produccion'] == true) {
      _saveTime();

      Navigator.push(
          context,
          _slideTransition(BotonPadreProduccion(
            texto: 'produccion',
            tipoProceso: '1',
            motCodOdt: widget.motCodOdt,
            secuencyMachine: widget.secuencyMachine,
            motNroElem: widget.motNroElem,
            odtMaq: widget.odtMaq,
            complement: widget.complement,
            generado: widget.generado,
          )));
    } else if (evento['navigate'] == true) {
      Navigator.push(
          context,
          _slideTransition(const EventosGeneralScreen(
            tipoProceso: '2',
          )));
    }
  }*/

  PageRouteBuilder _slideTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 350),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }
}
