import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_tareo/providers/event_p_provider.dart';

class StockAlmacen extends StatefulWidget {
  const StockAlmacen({super.key});

  @override
  State<StockAlmacen> createState() => _StockAlmacenState();
}

class _StockAlmacenState extends State<StockAlmacen> {
  final TextEditingController _buscarStock = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SizedBox(
                width: size.width,
                height: 40,
                child: TextField(
                    controller: _buscarStock,
                    style: const TextStyle(fontSize: 12),
                    decoration:   InputDecoration(
                      hintText: '🔍  Buscar stock...',
                       // prefixIcon: const Icon(Icons.search,size: 20,),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 22, 56, 78),
                              ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 22, 56, 78),
                              ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        filled: true,
                    fillColor: Colors.white,
                        contentPadding:  const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        ),
                  ),
              ),
            ),
              Expanded(
                child: Consumer<EventPProvider>(
                  builder: ( context,  value,  child) { 
                    return ListView.builder(
                    itemCount: value.evenPrep.length,
                    itemBuilder: (context, index){
                      final event = value.evenPrep[index];
                      return  Column(
                        children: [
                          ListTile(
                            title: Text(' ${event.codeEvent}') ,
                            subtitle: Text('${event.description}', style:  TextStyle(fontSize: 12),),
                            trailing: Icon(Icons.image),
                            ),
                            Divider()
                        ],
                      );
                    });
                   },
                 
                ),
              )
          ],
        ),
      ),
    );
  }
}