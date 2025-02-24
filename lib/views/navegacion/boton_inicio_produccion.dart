import 'package:flutter/material.dart';

class InicioProduccion extends StatefulWidget {
  const InicioProduccion({super.key, required this.texto});
  final String texto;

 
  @override
  State<InicioProduccion> createState() => _InicioProduccionState();
}

class _InicioProduccionState extends State<InicioProduccion> {
  String estadoMaquina = "En espera";

  Color estadoColor = Colors.grey;

  bool produciendo = false;

  void iniciarProduccion() {
    setState(() {
      if (produciendo) {
        estadoMaquina = "Finalizado";
        estadoColor = Colors.grey;
      } else {
        estadoMaquina = "Produciendo";
        estadoColor = Colors.green;
      }
      produciendo = !produciendo;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title:  Text(widget.texto, style: const TextStyle(fontSize: 14),)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.1),
            // Información del usuario
            const Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage("https://media.licdn.com/dms/image/v2/C4E03AQEdSK4YkDhv0w/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1658904251136?e=2147483647&v=beta&t=_O6mtTA6_7TPfhr8mpnBwJuYPze-590YZM9T4w8Hr6k"),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Usuario: Ricardo Monago", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("Turno: Mañana", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
             SizedBox(height: size.height * 0.1),
            
            // Estado de la máquina
            /*Card(
              elevation: 5,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: estadoColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Estado: $estadoMaquina",
                  style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),*/
            
            const SizedBox(height: 20),
            
            // Botón de inicio de producción
            ElevatedButton(
              onPressed: iniciarProduccion,
              style: ElevatedButton.styleFrom(
                backgroundColor: produciendo ? Colors.red : Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              child: Text(produciendo ? "FINALIZAR" : "INICIAR ${widget.texto}", style: const TextStyle(fontSize: 13),),
            ),
            
        
            
          ],
        ),
      ),
    );
  }
}