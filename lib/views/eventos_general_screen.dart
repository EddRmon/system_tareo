// lib/views/eventos_general_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_tareo/views/navegacion/boton_inicio_evento.dart';


import 'package:system_tareo/viewsmodel/event_viewmodel.dart';
import 'package:system_tareo/widgets/search_bar_widget.dart';

class EventosGeneralScreen extends StatelessWidget {
  const EventosGeneralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventViewModel(),
      child: const EventosGeneralContent(),
    );
  }
}

class EventosGeneralContent extends StatelessWidget {
  const EventosGeneralContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    final eventViewModel = Provider.of<EventViewModel>(context);

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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BotonInicioEvento(texto: item.text),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Seleccionaste: ${item.text}"),
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