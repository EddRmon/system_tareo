import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnidadesProcesadas extends StatefulWidget {
  const UnidadesProcesadas({super.key, required this.onFinish, required this.text});
  final VoidCallback onFinish;
  final String text;

  @override
  State<UnidadesProcesadas> createState() => _UnidadesProcesadasState();
}

class _UnidadesProcesadasState extends State<UnidadesProcesadas> {
  final TextEditingController piegosParcialesMalosController = TextEditingController();
  final TextEditingController obsController = TextEditingController();
  final TextEditingController piegosParcialesController = TextEditingController();

  String tipoCaja = "Seleccionar";
  String causaSeleccionada = "Seleccionar Causa";
  String seccionSeleccionada = "Seleccionar Sección";

  @override
  void dispose() {
    piegosParcialesMalosController.dispose();
    obsController.dispose();
    piegosParcialesController.dispose();
    super.dispose();
  }

  void finalizarProceso() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('procesoPendiente', false);
    await prefs.setInt('circleColor', Colors.green.value); // Volver a verde al finalizar
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            SizedBox(
              width: size.width * 0.9,
              child: DropdownButton<String>(
                isExpanded: true,
                value: tipoCaja,
                items: ["Seleccionar", "Tipo A", "Tipo B", "Tipo C"].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(fontSize: 12)));
                }).toList(),
                onChanged: (String? newValue) => setState(() => tipoCaja = newValue ?? "Seleccionar"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTextField("Piegos parciales", piegosParcialesController, isNumeric: true),
                _buildTextField("Pliegos malos", piegosParcialesMalosController, isNumeric: true),
              ],
            ),
            const SizedBox(height: 10),
            _buildTextField2("Observaciones", obsController, isNumeric: false),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                finalizarProceso(); // Marcar como finalizado y volver a verde
                widget.onFinish(); // Notificar al padre
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              child: const Text("FINALIZAR", style: TextStyle(fontSize: 11, color: Colors.white), textAlign: TextAlign.center),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    finalizarProceso();
                    Navigator.pop(context);
                  },
                  child: const Text('Cerrar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumeric = false}) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: size.width * 0.4,
        child: TextFormField(
          controller: controller,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 12),
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField2(String label, TextEditingController controller, {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 12),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        ),
      ),
    );
  }
}