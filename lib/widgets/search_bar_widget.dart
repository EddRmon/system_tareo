// lib/widgets/search_bar_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_tareo/viewsmodel/event_viewmodel.dart';


class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final eventViewModel = Provider.of<EventViewModel>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 40,
      child: TextField(
        style: const TextStyle(fontSize: 12),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: 'Buscar eventos...',
          hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
          prefixIcon: const Icon(Icons.search, size: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        ),
        onChanged: (query) {
          eventViewModel.searchEvents(query);
        },
        
      ),
    );
  }
}

