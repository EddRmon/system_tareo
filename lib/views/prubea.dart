import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Panel de Producción"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Registros"),
              Tab(text: "Órdenes"),
              Tab(text: "Eventos"),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Usuario: Teobaldo", style: TextStyle(color: Colors.white, fontSize: 18)),
                    SizedBox(height: 10),
                    Text("Máquina: ENTHRONE 5", style: TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Inicio"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Cerrar Sesión"),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildProductionList(),
            _buildOrderList(),
            _buildEventList(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductionList() {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text("Orden #${index + 1}"),
            subtitle: Text("Estado: Pendiente"),
            trailing: ElevatedButton(
              onPressed: () {},
              child: Text("Ver"),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrderList() {
    return Center(child: Text("Órdenes de Trabajo (OTs)"));
  }

  Widget _buildEventList() {
    return Center(child: Text("Eventos registrados"));
  }
}