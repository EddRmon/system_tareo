import 'package:flutter/material.dart';

class BotonInicioEventogeneral extends StatefulWidget {
  const BotonInicioEventogeneral({super.key, required this.onFinish, required this.text});
  final VoidCallback onFinish;
  final String text;

  @override
  State<BotonInicioEventogeneral> createState() => _BotonInicioEventogeneralState();
}

class _BotonInicioEventogeneralState extends State<BotonInicioEventogeneral> {

  final TextEditingController piegosParcialesMalosController = TextEditingController();
  final TextEditingController obsController = TextEditingController();
  final TextEditingController piegosParcialesController = TextEditingController();

  String tipoCaja = "Seleccionar";
  String causaSeleccionada = "Seleccionar Causa";
  String seccionSeleccionada = "Seleccionar Sección";

  @override
  void dispose() {
    super.dispose();
    piegosParcialesMalosController.dispose();
    obsController.dispose();
    piegosParcialesController.dispose();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTextField("Piegos parciales", piegosParcialesController, isNumeric: true),
                 _buildTextField("Pliegos malos", piegosParcialesMalosController, isNumeric: true),
              ],
            ),
            const SizedBox(height: 10),
            _buildTextField2("Observaciones", obsController, isNumeric: false),
            
            ElevatedButton(
              onPressed: () {
                // Llama al callback para notificar a InicioProduccion que se presionó "INICIAR"
                widget.onFinish();
                Navigator.of(context).pop(); // Cierra el AlertDialog
                Navigator.of(context).pop(); // Cierra el diálogo
                
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              child:  const Text("FINALIZAR", style:   TextStyle(fontSize: 11, color: Colors.white),textAlign: TextAlign.center,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: const Text('Cerrar'))
              ],
            )
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
        width:  size.width * 0.4,
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
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
      ),
    );
  }
}