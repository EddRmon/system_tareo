import 'package:flutter/material.dart';


class ContenidoOp extends StatelessWidget {
  const ContenidoOp({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ColoredBox(
      color: const Color.fromARGB(255, 223, 237, 248),
      child: SizedBox(
        height: size.height * 0.13,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                elevation: 1,
                color: const Color.fromARGB(255, 243, 245, 245),
                shape: const RoundedRectangleBorder(side: BorderSide.none),
                child: ListTile(
                  onTap: () {
                   /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TiposEventos()));*/
                  },
                  title: Text('Orden #${index + 1}'),
                  subtitle: const Text("Estado: Pendiente"),
                  leading: const CircleAvatar(backgroundImage: NetworkImage('https://studioa.pe/wp-content/uploads/2021/04/studioa_alicorp_branding_logo.png', scale: 1.0),),
                  trailing: Card(
                    elevation: 5,
                    color: Colors.orange,
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
