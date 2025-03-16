import 'package:flutter/material.dart';
import 'package:system_tareo/views/navegacion/buscar_op_pendiente.dart';
import 'package:system_tareo/views/navegacion/buscar_op_vista.dart';
import 'package:system_tareo/views/navegacion/registro_actividades.dart';
import 'package:system_tareo/views/navegacion/stock_almacen.dart';
import 'package:system_tareo/widgets/navegacion/drawer_usuario.dart';

class BarraNavegacion extends StatefulWidget {
  const BarraNavegacion({super.key, required this.maquina});
  final String? maquina;

  @override
  State<BarraNavegacion> createState() => _BarraNavegacionState();
}

class _BarraNavegacionState extends State<BarraNavegacion> {
  
  @override
  Widget build(BuildContext context) {
    String onbtenerIdMaquina(String texto) {
      List<String> idMaquina = texto.split('-');
      String idmaq = idMaquina[0];
      return idmaq;
    }

    Color colorAzulClaro = const Color.fromARGB(
        255, 118, 133, 216); // Reemplaza con el código correcto
    return DefaultTabController(
      length: 4,
      // ignore: deprecated_member_use
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Tareo ${widget.maquina}',
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            bottom: const TabBar(
              unselectedLabelColor: Colors.black,
              labelStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              indicatorPadding: EdgeInsets.zero,
              indicatorColor: Colors.black,
              tabs: [
                //Tab(text: "Inicio"),
                Tab(text: "Trabajo"),
                Tab(text: "Estados"),
                Tab(text: "Registro"),
                Tab(text: "Stock"),
                //Tab(text: "Prog"),
              ],
            ),
            actions: const [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://media.licdn.com/dms/image/v2/C4E03AQEdSK4YkDhv0w/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1658904251136?e=2147483647&v=beta&t=_O6mtTA6_7TPfhr8mpnBwJuYPze-590YZM9T4w8Hr6k'),
              ),
              SizedBox(
                width: 8,
              )
            ],
            backgroundColor: colorAzulClaro,
          ),
          drawer: const DrawerUsuario(),
          body: TabBarView(
            children: [
               BuscarOpVista(idMaq:onbtenerIdMaquina(widget.maquina!),),
               //PreviaEvento1(idMaq: '164644', op: '195',),
              BuscarOpPendiente(
                idMaquina: onbtenerIdMaquina(widget.maquina!),
              ),
              const RegistroActividades(),
              const StockAlmacen(),
              //const ProgramaOpMaquinas()
            ],
          ),
        ),
      ),
    );
  }
}
