import 'package:flutter/material.dart';
import 'package:system_tareo/views/navegacion/buscar_op_pendiente.dart';
import 'package:system_tareo/views/navegacion/registro_actividades.dart';
import 'package:system_tareo/views/navegacion/stock_almacen.dart';
import 'package:system_tareo/widgets/navegacion/drawer_usuario.dart';

class BarraNavegacion extends StatelessWidget {
  const BarraNavegacion({super.key});


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
            title: const Text('Tareo', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),),
            bottom: const TabBar(
              unselectedLabelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
              indicatorPadding: EdgeInsets.zero,
              indicatorColor: Colors.black,
              
              tabs: [
                //Tab(text: "Inicio"),
                Tab(text: "Ops"),
                Tab(text: "Registro"),
                Tab(text: "Stock"),
                
              ],
            ),
            actions: const [ CircleAvatar(backgroundImage: NetworkImage('https://media.licdn.com/dms/image/v2/C4E03AQEdSK4YkDhv0w/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1658904251136?e=2147483647&v=beta&t=_O6mtTA6_7TPfhr8mpnBwJuYPze-590YZM9T4w8Hr6k'),),SizedBox(width: 8,)],
            backgroundColor: const Color.fromARGB(255, 5, 124, 179),
          ),
          drawer: const DrawerUsuario(),
          body: const TabBarView(
            children: [
              //VistaInicio(),
              BuscarOpPendiente(),
              RegistroActividades(),
              StockAlmacen(),
              
            ],
          ),
        
        ),
      ),
    );
  }
}
