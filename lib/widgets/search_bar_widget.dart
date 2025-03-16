// lib/widgets/search_bar_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_tareo/providers/event_m_provider.dart';

class InputBuscar extends StatefulWidget {
  const InputBuscar({super.key});

  @override
  State<InputBuscar> createState() => _InputBuscarState();
}

class _InputBuscarState extends State<InputBuscar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
 
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size.width,
        height: 60,
        child: TextField(
          controller: _searchController,
          style: const TextStyle(fontSize: 12),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: 'Buscar eventos...',
            hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
            prefixIcon: const Icon(Icons.search, size: 18),
            suffixIcon: IconButton(
                onPressed: () {
                  _searchController.clear();
                  context.read<EventMProvider>().buscarEventos('');
                }, icon: const Icon(Icons.cancel_outlined)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          ),
          onChanged: (query) {
            context.read<EventMProvider>().buscarEventos(query);
          },
        ),
      ),
    );
  }
}
