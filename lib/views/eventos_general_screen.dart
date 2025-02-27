// lib/views/eventos_general_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_tareo/views/navegacion/tipos_eventos/boton_padre_eventogeneral.dart';
import 'package:system_tareo/viewsmodel/event_viewmodel.dart';
import 'package:system_tareo/widgets/search_bar_widget.dart';

class EventosGeneralScreen extends StatefulWidget {
  const EventosGeneralScreen({super.key});

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

  Future<void> _saveTime() async {
    final prefs = await SharedPreferences.getInstance();
    final  now = DateTime.now();
    final formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    await prefs.setString('savedTime', formattedTime);
    
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    final eventViewModel = Provider.of<EventViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              const Divider(color: Colors.grey),
              const Text(
                'Eventos',
                style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(color: Colors.grey),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: SearchBarWidget(), // Widget reutilizable para el buscador
              ),
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
                    itemCount: eventViewModel.events.length,
                    itemBuilder: (context, index) {
                      final item = eventViewModel.events[index];
                      return InkWell(
                        onTap: () {
                          _saveTime();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BotonPadreEventogeneral(texto: item.text),
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
                              gradient: LinearGradient(colors: item.gradient),
                            ),
                            child: Center(
                              child: Text(
                                item.text,
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