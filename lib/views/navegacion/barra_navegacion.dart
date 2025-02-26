import 'package:flutter/material.dart';
import 'package:system_tareo/views/navegacion/buscar_op_pendiente.dart';
import 'package:system_tareo/views/navegacion/registro_actividades.dart';
import 'package:system_tareo/views/navegacion/stock_almacen.dart';
import 'package:system_tareo/widgets/navegacion/drawer_usuario.dart';

class BarraNavegacion extends StatelessWidget {
  const BarraNavegacion({super.key});
/*
  // Función que devuelve un Stream con la hora actualizada cada segundo
  Stream<String> getHoraStream() {
    return Stream.periodic(const Duration(seconds: 1), (_) {
      return DateFormat('hh:mm:ss a').format(DateTime.now());
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      // ignore: deprecated_member_use
      child: WillPopScope(
        onWillPop: () async { 
          return false;
         },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Tareo'),
            bottom: const TabBar(
              labelStyle: TextStyle(fontSize: 15),
              indicatorPadding: EdgeInsets.zero,
              tabs: [
                Tab(text: "Pendiente"),
                Tab(text: "Registro"),
                Tab(text: "Stock"),
              ],
            ),
          ),
          drawer: const DrawerUsuario(),
          body: const TabBarView(
            children: [
              BuscarOpPendiente(),
              RegistroActividades(),
              StockAlmacen(),
            ],
          ),
         /* floatingActionButton: Container(
            height: 60,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle
            ),
            
            child: Center(
              child: StreamBuilder<String>(
                stream: getHoraStream(),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.data ?? '',
                    style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
          ),*/
        ),
      ),
    );
  }
}
