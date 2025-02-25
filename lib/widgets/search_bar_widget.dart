// lib/widgets/search_bar_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_tareo/viewsmodel/event_viewmodel.dart';


class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final eventViewModel = Provider.of<EventViewModel>(context, listen: false);
    return TextField(
      decoration: InputDecoration(
        hintText: 'Buscar eventos...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 236, 236, 236),
      ),
      onChanged: (query) {
        eventViewModel.searchEvents(query);
      },
      
    );
  }
}