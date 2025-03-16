// lib/views/eventos_general_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_tareo/providers/event_m_provider.dart';
import 'package:system_tareo/views/navegacion/tipos_eventos/boton_padre_eventogeneral.dart';
import 'package:system_tareo/viewsmodel/event_viewmodel.dart';
import 'package:system_tareo/widgets/search_bar_widget.dart';

class EventosGeneralScreen extends StatefulWidget {
  const EventosGeneralScreen({super.key, required this.tipoProceso});
  final String tipoProceso;

  @override
  State<EventosGeneralScreen> createState() => _EventosGeneralScreenState();
}

class _EventosGeneralScreenState extends State<EventosGeneralScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventViewModel(),
      child: const EventosGeneralContent(),
    );
  }
}

class EventosGeneralContent extends StatefulWidget {
  const EventosGeneralContent({super.key});

  @override
  State<EventosGeneralContent> createState() => _EventosGeneralContentState();
}

class _EventosGeneralContentState extends State<EventosGeneralContent> {
  Color colorAmarillo = const Color(0xFFFFF5CC);
  Color colorAzulClaro = const Color.fromARGB(255, 118, 133, 216);

  Future<void> _saveTime() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    await prefs.setString('savedTime', formattedTime);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EventMProvider>().eventMProvider();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    //final eventViewModel = Provider.of<EventViewModel>(context);

    return Scaffold(
        backgroundColor: colorAzulClaro,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                  expandedHeight: 100,
                  floating: true,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text(
                      'Eventos',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    background: Image.network(
                        'https://images.pexels.com/photos/176851/pexels-photo-176851.jpeg?auto=compress&cs=tinysrgb&w=300',
                        fit: BoxFit.cover),
                  )),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate:_CustomHeaderDelegate() ),
                  /*SliverToBoxAdapter(
                    child: InputBuscar(),
                  )*/
              Consumer<EventMProvider>(
                        builder: (context, eventM, child) {
                          return SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isLandScape ? 3 : 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 1.5,
                            ),
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                              final event = eventM.eventsGen[index];
                              if (eventM.isLoading) {
                                return Center(
                                  child: LoadingAnimationWidget.threeRotatingDots(
                                      color:
                                          const Color.fromARGB(255, 63, 80, 177),
                                      size: 50),
                                );
                              }
                              return InkWell(
                                onTap: () {
                                  _saveTime();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BotonPadreEventogeneral(
                                              texto: event.description),
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
                                      gradient: const LinearGradient(colors: [
                                        Color.fromARGB(255, 24, 65, 45),
                                        Colors.greenAccent
                                      ]),
                                    ),
                                    child: Center(
                                      child: Text(
                                        event.description,
                                        style: TextStyle(
                                          fontSize: isLandScape
                                              ? size.height * 0.04
                                              : size.height * 0.014,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }, childCount: eventM.eventsGen.length),
                          );
                        },
                      ),
            ],
          ),
        ));
  }
}

class _CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const InputBuscar();
  }

  @override
  double get maxExtent => 60; // Altura máxima

  @override
  double get minExtent => 60; // Altura mínima (igual si no quieres que cambie)

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
