/*import 'package:flutter/material.dart';
import 'package:system_tareo/views/navegacion/barra_navegacion.dart';

class NavegadorPrincipal extends StatefulWidget {
  const NavegadorPrincipal({super.key});

  @override
  State<NavegadorPrincipal> createState() => _NavegadorPrincipalState();
}

class _NavegadorPrincipalState extends State<NavegadorPrincipal> {
  int indice = 0;
  List<Widget> vistas = [
    const BarraNavegacion(),
    const Center(child: Text('Produccion')),
    
  ];

  void _pagSelect(int index){
    setState(() {
      indice = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: vistas[indice],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey,
        unselectedLabelStyle: const TextStyle(color: Colors.green),
        selectedLabelStyle: const TextStyle(color: Colors.green),
        elevation: 50,
        onTap: _pagSelect,
        currentIndex: indice,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.waving_hand,
                    color: indice == 0 ? Colors.white : Colors.black, size: 20)),
            BottomNavigationBarItem(
                label: 'Qr',
                icon: Icon(Icons.qr_code_2_outlined,
                    color: indice == 1 ? Colors.white : Colors.black, size: 20,)),
        ],),
    );
  }
}*/