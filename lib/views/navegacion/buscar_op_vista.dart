import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:system_tareo/providers/op_program_provider.dart';
import 'package:system_tareo/views/navegacion/eventos.dart';

class BuscarOpVista extends StatefulWidget {
  const BuscarOpVista({
    super.key,
    required this.idMaq,
  });

  final String idMaq;
  @override
  State<BuscarOpVista> createState() => _BuscarOpVistaState();
}

class _BuscarOpVistaState extends State<BuscarOpVista> {
  final TextEditingController _opBuscarController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          /*SliverAppBar(
            expandedHeight: 100,
            floating: true,
            pinned: true,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Aqui va al Buscar op',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              background: Image.network(
                'https://images.pexels.com/photos/9550363/pexels-photo-9550363.jpeg?auto=compress&cs=tinysrgb&w=300',
                fit: BoxFit.cover,
              ),
            ),
          ),*/
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * 0.5,
                    height: 40,
                    child: TextField(
                      focusNode: _focusNode,
                      controller: _opBuscarController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      maxLength: 6,
                      autofocus: false,
                      decoration: InputDecoration(
                          counterText: '',
                          hintText: 'Buscar...',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          prefixIcon: const Icon(Icons.file_copy),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8)),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final nuevaOp = _opBuscarController.text.trim();
                        context
                            .read<OpProgramProvider>()
                            .obtenerOps(nuevaOp, widget.idMaq);
                        _focusNode.unfocus();
                        FocusScope.of(context).unfocus();
                        _opBuscarController.clear();
                      },
                      child: const Icon(Icons.check))
                ],
              ),
            ),
          ),

          // Usamos Consumer para escuchar cambios en el Provider
          Consumer<OpProgramProvider>(
            builder: (context, opProvider, child) {
              // Estado de carga
              if (opProvider.isLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              // Estado vacío
              if (opProvider.listaOps.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: Text('No hay operaciones disponibles')),
                );
              }

              // Lista con datos
              return SliverList.separated(
                itemCount: opProvider.listaOps.length,
                // Los elementos principales son las tarjetas (Card)
                itemBuilder: (context, index) {
                  final op = opProvider.listaOps[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    TiposEventos(
                              motCodOdt: op.motCodOdt,
                              secuencyMachine: op.secuencyMachine,
                              motNroElem: op.motNroElem,
                              odtMaq: op.motCodMaq,
                              complement: op.motNroComplem, generado: op.motEstado,
                            ),
                            transitionDuration:
                                const Duration(milliseconds: 350),
                            transitionsBuilder: (context, animation,
                                animationSecondary, child) {
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
                      child: Card(
                        elevation: 5,
                        color: Colors.blue[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 8, 35, 126), width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'OP: ${op.motCodOdt}',
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Elemento: ${op.motNroElem}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.send),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(color: Colors.grey),
                              _infoRow2('🏢 Descripción:', op.motDescrip),
                              const Divider(color: Colors.grey),
                              _infoRow2(
                                  'Fecha/Hora: Inicio Prod.', '${op.motFini}'),
                              const Divider(color: Colors.grey),
                              _infoRow2(
                                  'Fecha/Hora: Fin Prod.', '${op.motFfin}'),
                              const Divider(color: Colors.grey),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _infoRow('Tipo: ', op.motTipoMaq),
                                        _infoRow('Tiraje: ', op.motTirRet),
                                        _infoRowSecuencia(
                                            'Sec: ', op.secuencyMachine),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _infoRow('Pliegos: ', op.motPliegos),
                                        _infoRow('Cantidad: ', op.motCant),
                                        _infoRow('Estado: ', op.motEstado),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                // Los separadores son los Divider
                separatorBuilder: (context, index) => const Divider(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _infoRowSecuencia(String title, String value,
      {Color textColor = Colors.green}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: textColor, fontSize: 18),
          ),
          Text(value, style: TextStyle(color: textColor, fontSize: 18)),
        ],
      ),
    );
  }

  Widget _infoRow(String title, String value,
      {Color textColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
          ),
          Text(value, style: TextStyle(color: textColor)),
        ],
      ),
    );
  }

  Widget _infoRow2(String title, String value,
      {Color textColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
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
}
