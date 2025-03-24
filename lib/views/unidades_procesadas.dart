import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_tareo/providers/actu_evento_fin_provider.dart';

class UnidadesProcesadas extends StatefulWidget {
  const UnidadesProcesadas(
      {super.key,
      required this.onFinish,
      required this.text,
      required this.op,
      required this.idMaq});
  final VoidCallback onFinish;
  final String text;
  final String op;
  final String idMaq;

  @override
  State<UnidadesProcesadas> createState() => _UnidadesProcesadasState();
}

class _UnidadesProcesadasState extends State<UnidadesProcesadas> {
  final TextEditingController piegosParcialesMalosController =
      TextEditingController();
  final TextEditingController obsController = TextEditingController();
  final TextEditingController piegosParcialesController =
      TextEditingController();

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
    await prefs.setInt(
        'circleColor', Colors.green.value); // Volver a verde al finalizar
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
                items: ["Seleccionar", "Tipo A", "Tipo B", "Tipo C"]
                    .map((String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(fontSize: 12)));
                }).toList(),
                onChanged: (String? newValue) =>
                    setState(() => tipoCaja = newValue ?? "Seleccionar"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTextField("Piegos parciales", piegosParcialesController,
                    isNumeric: true),
                _buildTextField("Pliegos malos", piegosParcialesMalosController,
                    isNumeric: true),
              ],
            ),
            const SizedBox(height: 10),
            _buildTextField2("Observaciones", obsController, isNumeric: false),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                finalizarProceso(); // Marcar como finalizado y volver a verde
                widget.onFinish(); // Notificar al padre

             

                showDialog(
                    context: context,
                    builder: (_) {
                      return Center(
                        child: LoadingAnimationWidget.threeRotatingDots(
                            color: const Color.fromARGB(255, 63, 80, 177),
                            size: 50),
                      );
                    });

                //finalizarProceso();
                print(' ${obsController.text}');
                print(' ${piegosParcialesController.text}');
                print(' ${piegosParcialesMalosController.text}');
                print(' ${widget.op}');
                print(' ${widget.idMaq}');
                try {
                  await context.read<ActuEventoFinProvider>().actualizarEvento(
                      observsa: obsController.text,
                      pliegosbuenos: piegosParcialesController.text,
                      pliegosmalos: piegosParcialesMalosController.text,
                      op: widget.op,
                      codMaquina: widget.idMaq);
                    if (!mounted) return;

                showDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      //barrierDismissible: false,
                      builder: (BuildContext context) {
                        // ignore: avoid_print
                        
                        return const AlertDialog(
                          content: Text('Se actualizó correctamente'),
                        );
                      });
                Navigator.of(context, rootNavigator: true).pop(); // Cierra el loading
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.of(context, rootNavigator: true).pop(); 
                 
                } catch (e) {
                  if (!mounted) return;
                  showDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      //barrierDismissible: false,
                      builder: (BuildContext context) {
                        // ignore: avoid_print
                        print('Error: $e');
                        return AlertDialog(
                          content: Text('El error $e'),
                        );
                      });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              child: const Text("FINALIZAR",
                  style: TextStyle(fontSize: 11, color: Colors.white),
                  textAlign: TextAlign.center),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
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
  

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isNumeric = false}) {
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField2(String label, TextEditingController controller,
      {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 12),
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        ),
      ),
    );
  }
}
