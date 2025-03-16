import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_tareo/providers/op_program_provider.dart';

class PreviaEvento1 extends StatefulWidget {
  const PreviaEvento1({super.key, required this.idMaq, required this.op});
  final String idMaq;
  final String op;

  @override
  State<PreviaEvento1> createState() => _PreviaEventoState();
}

class _PreviaEventoState extends State<PreviaEvento1> {
  final ScrollController _scrollController = ScrollController();
  List<bool> _isExpanded = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<OpProgramProvider>();
      await provider.obtenerOps(widget.idMaq, widget.op);

      setState(() {
        _isExpanded = List.generate(provider.listaOps.length, (_) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orden: ${widget.op}')),
      body: Consumer<OpProgramProvider>(
        builder: (context, opProvider, _) {
          if (opProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (opProvider.listaOps.isEmpty) {
            return const Center(child: Text('No hay operaciones disponibles'));
          }

          // Asegura que _isExpanded esté sincronizado
          if (_isExpanded.length != opProvider.listaOps.length) {
            _isExpanded = List.generate(opProvider.listaOps.length, (_) => false);
          }

          return SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 8),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(), // Evita conflicto de scroll
                  shrinkWrap: true,
                  itemCount: opProvider.listaOps.length,
                  itemBuilder: (context, index) {
                    final op = opProvider.listaOps[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                      child: ExpansionTile(
                        key: Key(index.toString()),
                        initiallyExpanded: _isExpanded[index],
                        onExpansionChanged: (expanded) {
                          setState(() {
                            _isExpanded[index] = expanded;
                          });
                        },
                        leading: const Icon(Icons.task),
                        title: Text('OP: ${op.motCodOdt}'),
                        subtitle: Text('Elemento: ${op.motNroElem}'),
                        childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        children: [
                          _infoRow('Descripción:', op.motDescrip),
                          _infoRow('Inicio Producción:', '${op.motFini}'),
                          _infoRow('Fin Producción:', '${op.motFfin}'),
                          _infoRow('Tipo Máquina:', op.motTipoMaq),
                          _infoRow('Tiraje:', op.motTirRet),
                          _infoRow('Secuencia:', op.secuencyMachine),
                          _infoRow('Pliegos:', op.motPliegos),
                          _infoRow('Cantidad:', op.motCant),
                          _infoRow('Estado:', op.motEstado),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _infoRow(String title, String value, {Color textColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(value, style: TextStyle(color: textColor)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
