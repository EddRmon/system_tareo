import 'package:flutter/material.dart';

class ProgramaMaquinaScreen extends StatelessWidget {
  // Simulación de datos extraídos de la imagen en formato JSON
  final List<Map<String, dynamic>> datos = [
    {
      "inicio": "27/02 07:00",
      "duracion": "08:45",
      "cliente": "MANTENIMIENTO",
      "descripcion": "MANTENIMIENTO CORRECTIVO",
      "material": "",
      "cantidad": "0",
      "estado": "",
      "barniz": "",
      "observaciones": ""
    },
    
  ];

   ProgramaMaquinaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(" KOMORI L20")),
      body: ListView.builder(
        itemCount: datos.length,
        itemBuilder: (context, index) {
          final item = datos[index];
          return Card(
            color: Colors.white,
            elevation: 5,
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("📅 Inicio: ${item["inicio"]} | ⏳ Duración: ${item["duracion"]}",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("🏢 Cliente: ${item["cliente"]}"),
                  Text("📦 Descripción: ${item["descripcion"]}"),
                  Text("📝 Material: ${item["material"]}"),
                  Text("📊 Cantidad: ${item["cantidad"]}"),
                  Text("🔹 Estado: ${item["estado"]}", style: TextStyle(color: Colors.blue)),
                  Text("🎨 Barniz: ${item["barniz"]}"),
                  Text("📝 Observaciones: ${item["observaciones"]}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
