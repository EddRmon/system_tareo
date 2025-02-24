import 'package:flutter/material.dart';

class StockAlmacen extends StatefulWidget {
  const StockAlmacen({super.key});

  @override
  State<StockAlmacen> createState() => _StockAlmacenState();
}

class _StockAlmacenState extends State<StockAlmacen> {
  final TextEditingController _buscarStock = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            TextField(
                controller: _buscarStock,
                decoration:  const InputDecoration(
                  hintText: 'Buscar items',
                    prefixIcon: Icon(Icons.search,size: 20,),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Color.fromARGB(255, 221, 238, 245),
                    contentPadding: EdgeInsets.symmetric(vertical: 10)
                    ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index){
                    return const ListTile(
                      title: Text('Barniz acrilico') ,
                      subtitle: Text('Codigo SBA: 32465'),
                      trailing: Icon(Icons.image),
                      );
                  }),
              )
          ],
        ),
      ),
    );
  }
}