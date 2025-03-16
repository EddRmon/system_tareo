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

class Prueba extends StatefulWidget {
  
  @override
  State<Prueba> createState() => _PruebaState();
}

class _PruebaState extends State<Prueba> {
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
    Color colorAzulClaro =
        const Color.fromARGB(255, 118, 133, 216);

  Future<void> _saveTime() async {
    final prefs = await SharedPreferences.getInstance();
    final  now = DateTime.now();
    final formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    await prefs.setString('savedTime', formattedTime);
    
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<EventMProvider>().eventMProvider();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    //final eventViewModel = Provider.of<EventViewModel>(context);

    return Scaffold(
      backgroundColor: colorAzulClaro,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              const Divider(color: Colors.black),
              const Text(
                'Eventos',
                style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(color: Colors.black),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: InputBuscar(), // Widget reutilizable para el buscador
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Consumer<EventMProvider>(
                    builder: ( context, eventM, child) { 
                      return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isLandScape ? 3 : 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: eventM.eventsGen.length,
                      itemBuilder: (context, index) {
                        final item = eventM.eventsGen[index];
                        if(eventM.isLoading){
                          return Center(child: LoadingAnimationWidget.threeRotatingDots(color:const Color.fromARGB(255, 63, 80, 177) , size: 50),);
                        }
                        return InkWell(
                          onTap: () {
                            _saveTime();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BotonPadreEventogeneral(texto: item.description),
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
                                gradient: const LinearGradient(colors: [Color.fromARGB(255, 24, 65, 45),Colors.greenAccent]),
                              ),
                              child: Center(
                                child: Text(
                                  item.description,
                                  style: TextStyle(
                                    fontSize: isLandScape ? size.height * 0.04 : size.height * 0.014,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
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