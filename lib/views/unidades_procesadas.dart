import 'package:flutter/material.dart';

class UnidadesProcesadas extends StatefulWidget {
  const UnidadesProcesadas({super.key, required this.onStart});
  final VoidCallback onStart; // Callback para notificar cuando se presiona "INICIAR"

  @override
  State<UnidadesProcesadas> createState() => _UnidadesProcesadasState();
}

class _UnidadesProcesadasState extends State<UnidadesProcesadas> {
  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController obsController = TextEditingController();

  String tipoCaja = "Seleccionar";
  String causaSeleccionada = "Seleccionar Causa";
  String seccionSeleccionada = "Seleccionar Sección";

  @override
  void dispose() {
    super.dispose();
    cantidadController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0), // Padding reducido para el AlertDialog
      child: SingleChildScrollView( // Añadido para manejar scroll en el diálogo
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            SizedBox(
              width: size.width * 0.9,
              child: DropdownButton<String>(
                isExpanded: true,
                value: tipoCaja,
                items: ["Seleccionar", "Tipo A", "Tipo B", "Tipo C"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(fontSize: 12)),
                  );
                }).toList(),
                onChanged: (String? newValue) => setState(() => tipoCaja = newValue ?? "Seleccionar"),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: size.width * 0.9,
              child: DropdownButton<String>(
                isExpanded: true,
                value: causaSeleccionada,
                items: ["Seleccionar Causa", "Causa 1", "Causa 2", "Causa 3"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(fontSize: 12)),
                  );
                }).toList(),
                onChanged: (String? newValue) => setState(() => causaSeleccionada = newValue ?? "Seleccionar Causa"),
              ),
            ),
            const SizedBox(height: 10),
            _buildTextField("Observaciones", obsController, isNumeric: true),
            const SizedBox(height: 10),
            _buildTextField("Cantidad", cantidadController, isNumeric: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Llama al callback para notificar a InicioProduccion que se presionó "INICIAR"
                widget.onStart();
                Navigator.of(context).pop(); // Cierra el AlertDialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              child: const Text("FINALIZAR", style:   TextStyle(fontSize: 14, color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 12),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
      ),
    );
  }
}