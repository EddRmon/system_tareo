import 'package:flutter/material.dart';

class UnidadesProcesadas extends StatefulWidget {
  const UnidadesProcesadas({super.key});

  @override
  State<UnidadesProcesadas> createState() => _UnidadesProcesadasState();
}

class _UnidadesProcesadasState extends State<UnidadesProcesadas> {
  final TextEditingController cantidadController = TextEditingController();

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
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {   
        return false;
       },
      child: Scaffold(
        appBar: AppBar(title: const Text("Unidades Procesadas"),centerTitle: true, automaticallyImplyLeading: false,),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
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
                      child: Text(value, style: const TextStyle(fontSize: 12),),
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
                      child: Text(value, style: const TextStyle(fontSize: 12),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) => setState(() => causaSeleccionada = newValue ?? "Seleccionar Causa"),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width * 0.9,
                height: 50,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: seccionSeleccionada,
                  items: ["Seleccionar Sección", "Sección 1", "Sección 2", "Sección 3"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(fontSize: 12),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) => setState(() => seccionSeleccionada = newValue ?? "Seleccionar Sección"),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField("Cantidad", cantidadController, isNumeric: true),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                child: const Text("INICIAR"),
              ),
            ],
          ),
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
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
        ),
      ),
    );
  }
}