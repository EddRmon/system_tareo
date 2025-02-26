import 'package:flutter/material.dart';
import 'package:system_tareo/views/navegacion/eventos.dart';

class ContenidoOp extends StatelessWidget {
  const ContenidoOp({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ColoredBox(
      color: Colors.white,
      child: SizedBox(
        height: size.height * 0.7,
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Card(
                elevation: 1,
                color: const Color.fromARGB(255, 243, 245, 245),
                shape: const RoundedRectangleBorder(side: BorderSide.none),
                child: ListTile(
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
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                      ),
                    );

                  },
                  title: Text('OP ${index + 168146}'),
                  subtitle: const Text("Estado: Pendiente"),
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://studioa.pe/wp-content/uploads/2021/04/studioa_alicorp_branding_logo.png',
                        scale: 1.0),
                  ),
                  trailing: Card(
                    elevation: 4,
                    color: const Color.fromARGB(255, 22, 56, 78),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      //side: BorderSide.none
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                        top: 10,
                      ),
                      height: 50,
                      width: size.width * 0.16,
                      child: const Icon(
                        Icons.view_comfy,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
